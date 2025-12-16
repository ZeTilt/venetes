<?php

namespace App\Controller;

use App\Service\SiteConfigService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\String\Slugger\SluggerInterface;

#[Route('/admin/config', name: 'admin_config_')]
#[IsGranted('ROLE_ADMIN')]
class AdminConfigController extends AbstractController
{
    public function __construct(
        private SiteConfigService $siteConfigService,
        private SluggerInterface $slugger
    ) {
    }

    #[Route('/', name: 'index')]
    public function index(): Response
    {
        $clubInfo = $this->siteConfigService->getClubInfo();

        return $this->render('admin/config/index.html.twig', [
            'clubInfo' => $clubInfo,
        ]);
    }

    #[Route('/save', name: 'save', methods: ['POST'])]
    public function save(Request $request): Response
    {
        $clubName = $request->request->get('club_name');
        $clubAddress = $request->request->get('club_address');
        $clubPhone = $request->request->get('club_phone');
        $clubEmail = $request->request->get('club_email');
        $clubFacebook = $request->request->get('club_facebook');
        $helloassoUrl = $request->request->get('helloasso_url');

        $this->siteConfigService->set('club_name', $clubName, 'Nom du club');
        $this->siteConfigService->set('club_address', $clubAddress, 'Adresse du club');
        $this->siteConfigService->set('club_phone', $clubPhone, 'Téléphone du club');
        $this->siteConfigService->set('club_email', $clubEmail, 'Email du club');
        $this->siteConfigService->set('club_facebook', $clubFacebook, 'Page Facebook du club');
        $this->siteConfigService->set('helloasso_url', $helloassoUrl, 'Lien HelloAsso pour les adhésions');

        // Handle tarifs PDF upload
        $tarifsFile = $request->files->get('tarifs_pdf');
        if ($tarifsFile) {
            $originalFilename = pathinfo($tarifsFile->getClientOriginalName(), PATHINFO_FILENAME);
            $safeFilename = $this->slugger->slug($originalFilename);
            $newFilename = $safeFilename.'-'.uniqid().'.'.$tarifsFile->guessExtension();

            try {
                $tarifsFile->move(
                    $this->getParameter('kernel.project_dir').'/public/uploads/documents',
                    $newFilename
                );

                // Remove old file if exists
                $currentTarifsPath = $this->siteConfigService->get('tarifs_pdf');
                if ($currentTarifsPath) {
                    $oldFilePath = $this->getParameter('kernel.project_dir').'/public'.$currentTarifsPath;
                    if (file_exists($oldFilePath)) {
                        unlink($oldFilePath);
                    }
                }

                $this->siteConfigService->set('tarifs_pdf', '/uploads/documents/'.$newFilename, 'Fichier PDF des tarifs');
                $this->addFlash('success', 'Fichier des tarifs uploadé avec succès.');
            } catch (FileException $e) {
                $this->addFlash('error', 'Erreur lors de l\'upload du fichier.');
            }
        }

        // Handle homepage CTA config
        $homeCtaTitle = $request->request->get('home_cta_title');
        $homeCtaText = $request->request->get('home_cta_text');
        $homeCtaBtn1Text = $request->request->get('home_cta_btn1_text');
        $homeCtaBtn1Url = $request->request->get('home_cta_btn1_url');
        $homeCtaBtn2Text = $request->request->get('home_cta_btn2_text');
        $homeCtaBtn2Url = $request->request->get('home_cta_btn2_url');

        if ($homeCtaTitle) {
            $this->siteConfigService->set('home_cta_title', $homeCtaTitle, 'Titre CTA page d\'accueil');
        }
        if ($homeCtaText) {
            $this->siteConfigService->set('home_cta_text', $homeCtaText, 'Texte CTA page d\'accueil');
        }
        if ($homeCtaBtn1Text) {
            $this->siteConfigService->set('home_cta_btn1_text', $homeCtaBtn1Text, 'Bouton 1 - Texte');
        }
        if ($homeCtaBtn1Url) {
            $this->siteConfigService->set('home_cta_btn1_url', $homeCtaBtn1Url, 'Bouton 1 - URL');
        }
        if ($homeCtaBtn2Text) {
            $this->siteConfigService->set('home_cta_btn2_text', $homeCtaBtn2Text, 'Bouton 2 - Texte');
        }
        if ($homeCtaBtn2Url) {
            $this->siteConfigService->set('home_cta_btn2_url', $homeCtaBtn2Url, 'Bouton 2 - URL');
        }

        // Handle hero images
        $existingHeroImages = json_decode($request->request->get('hero_images', '[]'), true) ?: [];
        $heroFiles = $request->files->get('hero_images_upload');

        if ($heroFiles) {
            $uploadDir = $this->getParameter('kernel.project_dir').'/public/uploads/hero';
            if (!is_dir($uploadDir)) {
                mkdir($uploadDir, 0755, true);
            }

            foreach ($heroFiles as $heroFile) {
                if ($heroFile) {
                    $originalFilename = pathinfo($heroFile->getClientOriginalName(), PATHINFO_FILENAME);
                    $safeFilename = $this->slugger->slug($originalFilename);
                    $newFilename = $safeFilename.'-'.uniqid().'.'.$heroFile->guessExtension();

                    try {
                        $heroFile->move($uploadDir, $newFilename);
                        $existingHeroImages[] = '/uploads/hero/'.$newFilename;
                    } catch (FileException $e) {
                        $this->addFlash('error', 'Erreur lors de l\'upload d\'une image hero.');
                    }
                }
            }
        }

        $this->siteConfigService->set('hero_images', json_encode($existingHeroImages), 'Images du carousel d\'accueil');

        $this->addFlash('success', 'Configuration sauvegardée avec succès.');

        return $this->redirectToRoute('admin_config_index');
    }
}