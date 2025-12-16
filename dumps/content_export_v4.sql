SET FOREIGN_KEY_CHECKS=0;

-- Menu
INSERT INTO `menu` VALUES (1,'Menu principal','main',0,1,NOW(),NULL);

-- Modules
INSERT INTO `modules` VALUES (1,'blog','Blog & Articles','Gestion du contenu blog et articles',1,'{}',NOW(),NOW());

-- Site config
INSERT INTO `site_config` VALUES (1,'club_name','Club Subaquatique des Vénètes','Nom du club'),(2,'club_address','5 Av. du Président Wilson, 56000 Vannes','Adresse du club'),(3,'club_phone','02 97 XX XX XX','Téléphone du club'),(4,'club_email','contact@plongee-venetes.fr','Email du club'),(5,'club_facebook','https://www.facebook.com/plongeevenetes/','Page Facebook du club'),(6,'helloasso_url','https://www.helloasso.com/associations/club-subaquatique-les-venetes/adhesions/licence-et-adhesion-csv-2025-2026','Lien HelloAsso pour les adhésions'),(7,'tarifs_pdf','/uploads/documents/Tarifs-CSV-2025-68cd65d288190.pdf','Fichier PDF des tarifs');

-- Pages
INSERT INTO `pages` VALUES (1,1,'Formation Niveau 1','formation-niveau-1','Formation Niveau 1 FFESSM accessible dès 14 ans. Cours en piscine d\'octobre au printemps, validation en mer.','<div class=\"prose max-w-none\">
<h1>Formation Niveau 1</h1>

<div class=\"bg-blue-50 border-l-4 border-blue-400 p-4 mb-6\">
    <p class=\"text-sm text-blue-700\">
        <strong>Accessible dès 14 ans</strong> - Permet la plongée jusqu\'à 20 mètres sous supervision d\'un instructeur
    </p>
</div>

<div class=\"grid md:grid-cols-2 gap-8\">
    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Organisation de la formation</h2>
        <ul class=\"space-y-3\">
            <li class=\"flex items-start\">
                <span class=\"bg-club-orange text-white rounded-full w-6 h-6 flex items-center justify-center text-sm mr-3 mt-0.5\">1</span>
                <div>
                    <strong>Inscriptions</strong><br>
                    <span class=\"text-sm text-gray-600\">Début septembre</span>
                </div>
            </li>
            <li class=\"flex items-start\">
                <span class=\"bg-club-orange text-white rounded-full w-6 h-6 flex items-center justify-center text-sm mr-3 mt-0.5\">2</span>
                <div>
                    <strong>Formation piscine</strong><br>
                    <span class=\"text-sm text-gray-600\">D\'octobre au printemps</span>
                </div>
            </li>
            <li class=\"flex items-start\">
                <span class=\"bg-club-orange text-white rounded-full w-6 h-6 flex items-center justify-center text-sm mr-3 mt-0.5\">3</span>
                <div>
                    <strong>Plongées en mer</strong><br>
                    <span class=\"text-sm text-gray-600\">4 plongées entre avril et mai</span>
                </div>
            </li>
        </ul>

        <div class=\"mt-6 p-4 bg-yellow-50 rounded-lg\">
            <h3 class=\"font-semibold text-yellow-800\">Important</h3>
            <p class=\"text-sm text-yellow-700 mt-1\">
                La formation ne se fait pas en 1-2 semaines ! C\'est un processus progressif sur plusieurs mois.
            </p>
        </div>
    </div>

    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Compétences acquises</h2>
        <div class=\"space-y-3\">
            <div class=\"flex items-center\">
                <svg class=\"w-5 h-5 text-green-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                </svg>
                <span class=\"text-sm\">Préparation et montage du matériel</span>
            </div>
            <div class=\"flex items-center\">
                <svg class=\"w-5 h-5 text-green-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                </svg>
                <span class=\"text-sm\">Gestion du détendeur respiratoire</span>
            </div>
            <div class=\"flex items-center\">
                <svg class=\"w-5 h-5 text-green-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                </svg>
                <span class=\"text-sm\">Techniques de remontée contrôlée</span>
            </div>
            <div class=\"flex items-center\">
                <svg class=\"w-5 h-5 text-green-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                </svg>
                <span class=\"text-sm\">Vidage du masque</span>
            </div>
            <div class=\"flex items-center\">
                <svg class=\"w-5 h-5 text-green-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                </svg>
                <span class=\"text-sm\">Signes de communication sous-marine</span>
            </div>
        </div>

        <div class=\"mt-6\">
            <h3 class=\"text-lg font-semibold mb-2\">Lieu de formation</h3>
            <p class=\"text-sm text-gray-600\">
                <strong>Piscine :</strong> Formation technique d\'octobre au printemps<br>
                <strong>Mer :</strong> Validation dans le Golfe du Morbihan
            </p>
        </div>
    </div>
</div>

<div class=\"bg-club-orange-light p-6 rounded-lg mt-8\">
    <h3 class=\"text-lg font-semibold mb-2\">Objectif de la formation</h3>
    <p class=\"text-gray-700\">
        Profiter des beautés des fonds marins morbihanais en toute sécurité, accompagné d\'un encadrant qualifié.
    </p>
</div>
</div>','pages/page.html.twig','page','published',NULL,'Formation Niveau 1 - Club Subaquatique des Vénètes','Formation plongée Niveau 1 FFESSM au Club des Vénètes. Accessible dès 14 ans, formation progressive sur plusieurs mois.','[\"formation\", \"niveau 1\", \"plongée\", \"FFESSM\"]',NULL,NOW(),NOW(),0,0),
(2,1,'Les sorties','les-sorties','Découvrez nos sorties plongée dans le Golfe du Morbihan, la Ria d\'Etel et vers Houat. Sorties régulières pour tous niveaux.','<div class=\"prose max-w-none\">
<h1>Les sorties</h1>

<p>Les plongées s\'organisent en fonction des disponibilités et des envies des encadrants. Le Club Subaquatique des Vénètes propose des sorties régulières pour tous les niveaux.</p>

<div class=\"grid md:grid-cols-2 gap-8 mt-8\">
    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Organisation des sorties</h2>
        
        <div class=\"space-y-4\">
            <div class=\"p-4 bg-blue-50 rounded-lg\">
                <h3 class=\"font-semibold text-blue-800\">Planification</h3>
                <p class=\"text-sm text-blue-700 mt-1\">
                    Les directeurs de plongée annoncent les sorties lors des permanences du vendredi, avec :
                </p>
                <ul class=\"list-disc list-inside text-sm text-blue-700 mt-2 space-y-1\">
                    <li>Date et heure</li>
                    <li>Lieu de plongée</li>
                    <li>Niveau minimum requis</li>
                </ul>
            </div>

            <div class=\"p-4 bg-green-50 rounded-lg\">
                <h3 class=\"font-semibold text-green-800\">Fréquence</h3>
                <ul class=\"list-disc list-inside text-sm text-green-700 mt-1 space-y-1\">
                    <li>Haute saison : presque tous les week-ends</li>
                    <li>Plongées du soir en semaine</li>
                    <li>Sorties exceptionnelles vers des sites plus lointains</li>
                </ul>
            </div>
        </div>
    </div>

    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Destinations</h2>
        
        <div class=\"space-y-4\">
            <div>
                <h3 class=\"font-semibold text-club-orange\">Sites principaux</h3>
                <ul class=\"list-disc list-inside text-sm space-y-1 mt-2\">
                    <li><strong>Golfe du Morbihan</strong> - Notre terrain de jeu préféré</li>
                    <li><strong>Ria d\'Etel</strong> - Sorties régulières</li>
                    <li><strong>Île de Houat</strong> - Sorties à la journée</li>
                </ul>
            </div>

            <div class=\"p-4 bg-yellow-50 rounded-lg\">
                <h3 class=\"font-semibold text-yellow-800\">Réservations</h3>
                <div class=\"text-sm text-yellow-700 mt-1 space-y-2\">
                    <p><strong>Membres :</strong> Système de réservation en ligne</p>
                    <p><strong>Plongeurs extérieurs :</strong> Contact direct avec le directeur de plongée</p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class=\"bg-orange-50 border-l-4 border-orange-400 p-6 mt-8\">
    <h3 class=\"font-semibold text-orange-800\">Limitation pour Niveau 1</h3>
    <p class=\"text-sm text-orange-700\">
        Maximum 2 plongeurs Niveau 1 par encadrant déjà inscrit à la sortie.
    </p>
</div>

<div class=\"bg-club-orange-light p-6 rounded-lg mt-8\">
    <h3 class=\"text-lg font-semibold mb-4\">Rejoignez nos sorties !</h3>
    <p class=\"mb-4\">
        Participez à nos aventures sous-marines et découvrez les richesses du Golfe du Morbihan et des sites environnants.
    </p>
    <div class=\"flex flex-wrap gap-3\">
        <a href=\"/calendrier\" class=\"inline-block bg-club-orange text-white px-4 py-2 rounded hover:bg-club-orange-dark transition-colors\">
            Voir le calendrier
        </a>
        <a href=\"/contact\" class=\"inline-block border border-club-orange text-club-orange px-4 py-2 rounded hover:bg-club-orange hover:text-white transition-colors\">
            Nous contacter
        </a>
    </div>
</div>
</div>','pages/page.html.twig','page','published',NULL,'Les sorties - Club Subaquatique des Vénètes','Sorties plongée du Club des Vénètes : Golfe du Morbihan, Ria d\'Etel, Houat. Réservation en ligne pour les membres.','[\"sorties\", \"plongée\", \"Golfe du Morbihan\", \"Houat\"]',NULL,NOW(),NOW(),0,0),
(3,1,'Formation Niveau 2 et 3','formation-niveau-2-et-3','Formations Niveau 2 et 3 FFESSM : autonomie progressive de 20m à 40m. Inscriptions en septembre.','<div class=\"prose max-w-none\">
<h1>Formation Niveau 2 et 3</h1>

<div class=\"grid md:grid-cols-2 gap-8\">
    <div class=\"bg-blue-50 border-l-4 border-blue-400 p-6\">
        <h2 class=\"text-xl font-semibold mb-4 text-blue-800\">Niveau 2</h2>
        <div class=\"space-y-3 text-blue-700\">
            <p><strong>Premier niveau d\'autonomie</strong> sous la responsabilité d\'un Directeur de Plongée</p>
            <div class=\"bg-white p-3 rounded\">
                <h3 class=\"font-semibold\">Profondeurs autorisées :</h3>
                <ul class=\"list-disc list-inside text-sm mt-1\">
                    <li>0-20m en autonomie</li>
                    <li>Jusqu\'à 40m avec un guide</li>
                </ul>
            </div>
        </div>
    </div>

    <div class=\"bg-green-50 border-l-4 border-green-400 p-6\">
        <h2 class=\"text-xl font-semibold mb-4 text-green-800\">Niveau 3</h2>
        <div class=\"space-y-3 text-green-700\">
            <p><strong>Autonomie complète</strong> jusqu\'à 40m entre plongeurs</p>
            <div class=\"bg-white p-3 rounded\">
                <h3 class=\"font-semibold\">Privilèges :</h3>
                <ul class=\"list-disc list-inside text-sm mt-1\">
                    <li>Plongée autonome jusqu\'à 40m</li>
                    <li>Jusqu\'à 60m avec un Directeur de Plongée</li>
                </ul>
            </div>
            <p class=\"text-sm italic\">Rarement organisé par le club</p>
        </div>
    </div>
</div>

<div class=\"mt-8\">
    <h2 class=\"text-xl font-semibold mb-6\">Formation Niveau 2</h2>

    <div class=\"grid md:grid-cols-2 gap-6\">
        <div>
            <h3 class=\"text-lg font-semibold mb-4\">Prérequis</h3>
            <ul class=\"space-y-2\">
                <li class=\"flex items-center\">
                    <svg class=\"w-5 h-5 text-green-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                        <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                    </svg>
                    <span class=\"text-sm\">Être titulaire du Niveau 1</span>
                </li>
                <li class=\"flex items-center\">
                    <svg class=\"w-5 h-5 text-green-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                        <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                    </svg>
                    <span class=\"text-sm\">Expérience recommandée : 12 plongées</span>
                </li>
            </ul>

            <h3 class=\"text-lg font-semibold mt-6 mb-4\">Compétences acquises</h3>
            <ul class=\"space-y-2\">
                <li class=\"flex items-center\">
                    <span class=\"bg-club-orange text-white rounded-full w-6 h-6 flex items-center justify-center text-xs mr-2\">⬆</span>
                    <span class=\"text-sm\">Remontée sur bouée</span>
                </li>
                <li class=\"flex items-center\">
                    <span class=\"bg-club-orange text-white rounded-full w-6 h-6 flex items-center justify-center text-xs mr-2\">🆘</span>
                    <span class=\"text-sm\">Remontée d\'assistance depuis 20m</span>
                </li>
                <li class=\"flex items-center\">
                    <span class=\"bg-club-orange text-white rounded-full w-6 h-6 flex items-center justify-center text-xs mr-2\">👥</span>
                    <span class=\"text-sm\">Guide de palanquée</span>
                </li>
                <li class=\"flex items-center\">
                    <span class=\"bg-club-orange text-white rounded-full w-6 h-6 flex items-center justify-center text-xs mr-2\">🧭</span>
                    <span class=\"text-sm\">Navigation sous-marine</span>
                </li>
            </ul>
        </div>

        <div>
            <h3 class=\"text-lg font-semibold mb-4\">Organisation</h3>
            <div class=\"space-y-3\">
                <div class=\"p-3 bg-gray-50 rounded\">
                    <h4 class=\"font-semibold text-sm\">Inscriptions</h4>
                    <p class=\"text-sm text-gray-600\">Mi-septembre</p>
                </div>
                <div class=\"p-3 bg-gray-50 rounded\">
                    <h4 class=\"font-semibold text-sm\">Formation physique</h4>
                    <p class=\"text-sm text-gray-600\">Piscine + apnée d\'octobre à mai</p>
                </div>
                <div class=\"p-3 bg-gray-50 rounded\">
                    <h4 class=\"font-semibold text-sm\">Plongées techniques</h4>
                    <p class=\"text-sm text-gray-600\">Eau douce ou mer selon météo</p>
                </div>
                <div class=\"p-3 bg-gray-50 rounded\">
                    <h4 class=\"font-semibold text-sm\">Périodes intensives</h4>
                    <p class=\"text-sm text-gray-600\">Octobre-novembre et avril-mai</p>
                </div>
            </div>
        </div>
    </div>
</div>
</div>','pages/page.html.twig','page','published',NULL,'Formation Niveau 2 et 3 - Club Subaquatique des Vénètes','Formations plongée Niveau 2 et 3 au Club des Vénètes. Autonomie progressive, compétences techniques et navigation.','[\"formation\", \"niveau 2\", \"niveau 3\", \"autonomie\", \"FFESSM\"]',NULL,NOW(),NOW(),0,1),
(4,1,'Guide de palanquée','guide-de-palanquee','Formation Guide de palanquée (ex-Niveau 4) pour encadrer les plongeurs. Aide financière du club.','<div class=\"prose max-w-none\">
<h1>Guide de palanquée</h1>

<div class=\"bg-gradient-to-r from-club-orange to-club-orange-dark text-white p-6 rounded-lg mb-8\">
    <h2 class=\"text-2xl font-semibold mb-2\">Anciennement \"Niveau 4\"</h2>
    <p class=\"text-orange-100\">Formation d\'encadrant pour guider les plongeurs en toute sécurité</p>
</div>

<div class=\"grid md:grid-cols-2 gap-8\">
    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Prérequis</h2>
        <div class=\"space-y-3\">
            <div class=\"flex items-center p-3 bg-blue-50 rounded\">
                <svg class=\"w-6 h-6 text-blue-500 mr-3\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path fill-rule=\"evenodd\" d=\"M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z\" clip-rule=\"evenodd\"></path>
                </svg>
                <div>
                    <p class=\"font-semibold\">Niveau 3 requis</p>
                    <p class=\"text-sm text-gray-600\">Certification préalable obligatoire</p>
                </div>
            </div>

            <div class=\"flex items-center p-3 bg-orange-50 rounded\">
                <svg class=\"w-6 h-6 text-orange-500 mr-3\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path fill-rule=\"evenodd\" d=\"M3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z\" clip-rule=\"evenodd\"></path>
                </svg>
                <div>
                    <p class=\"font-semibold\">Condition physique</p>
                    <p class=\"text-sm text-gray-600\">Aisance parfaite et bonne condition physique</p>
                </div>
            </div>
        </div>

        <h3 class=\"text-lg font-semibold mt-6 mb-4\">Avantages club</h3>
        <div class=\"bg-green-50 p-4 rounded-lg\">
            <ul class=\"space-y-2 text-sm\">
                <li class=\"flex items-center\">
                    <span class=\"text-green-500 mr-2\">💰</span>
                    Aide financière à la formation
                </li>
                <li class=\"flex items-center\">
                    <span class=\"text-green-500 mr-2\">🎯</span>
                    Tarifs préférentiels
                </li>
                <li class=\"flex items-center\">
                    <span class=\"text-green-500 mr-2\">🤝</span>
                    Contrepartie : encadrement bénévole
                </li>
            </ul>
        </div>
    </div>

    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Formation</h2>
        <div class=\"space-y-4\">
            <div class=\"border-l-4 border-club-orange pl-4\">
                <h3 class=\"font-semibold\">Organisation</h3>
                <p class=\"text-sm text-gray-600\">Organisée par le département et le club</p>
            </div>

            <div class=\"border-l-4 border-blue-400 pl-4\">
                <h3 class=\"font-semibold\">Calendrier</h3>
                <ul class=\"text-sm text-gray-600 space-y-1\">
                    <li>• Inscription : mi-septembre</li>
                    <li>• Formation physique : octobre à mai</li>
                    <li>• Plongées techniques : octobre-novembre et avril-juin</li>
                </ul>
            </div>

            <div class=\"border-l-4 border-green-400 pl-4\">
                <h3 class=\"font-semibold\">Validation</h3>
                <p class=\"text-sm text-gray-600\">Examens théoriques, physiques et pratiques</p>
            </div>
        </div>

        <h3 class=\"text-lg font-semibold mt-6 mb-4\">Prérogatives</h3>
        <div class=\"bg-blue-50 p-4 rounded-lg\">
            <h4 class=\"font-semibold mb-2\">Autorisé à encadrer :</h4>
            <ul class=\"space-y-1 text-sm\">
                <li class=\"flex items-center\">
                    <span class=\"bg-blue-500 text-white rounded-full w-5 h-5 flex items-center justify-center text-xs mr-2\">N1</span>
                    Plongeurs Niveau 1 jusqu\'à 20 mètres
                </li>
                <li class=\"flex items-center\">
                    <span class=\"bg-blue-500 text-white rounded-full w-5 h-5 flex items-center justify-center text-xs mr-2\">N2</span>
                    Plongeurs Niveau 2 jusqu\'à 40 mètres
                </li>
            </ul>
        </div>
    </div>
</div>

<div class=\"bg-club-orange-light p-6 rounded-lg mt-8\">
    <h3 class=\"text-lg font-semibold mb-4\">🆘 Le club a besoin d\'encadrants !</h3>
    <p class=\"mb-4\">
        Devenez Guide de palanquée et participez activement à la vie du club en encadrant nos sorties et formations.
    </p>
    <div class=\"flex gap-3\">
        <a href=\"/contact\" class=\"bg-club-orange text-white px-4 py-2 rounded hover:bg-club-orange-dark\">
            Me renseigner
        </a>
        <a href=\"/calendrier\" class=\"border border-club-orange text-club-orange px-4 py-2 rounded hover:bg-club-orange hover:text-white\">
            Voir les formations
        </a>
    </div>
</div>
</div>','pages/page.html.twig','page','published',NULL,'Guide de palanquée - Club Subaquatique des Vénètes','Formation Guide de palanquée au Club des Vénètes. Encadrement N1 et N2, aide financière, contrepartie bénévolat.','[\"formation\", \"guide\", \"encadrement\", \"niveau 4\"]',NULL,NOW(),NOW(),0,0),
(5,1,'Autres formations','autres-formations','Formations spécialisées : Nitrox, RIFAP, Moniteur. Complétez votre cursus de plongeur.','<div class=\"prose max-w-none\">
<h1>Autres formations</h1>

<p class=\"text-lg text-gray-600 mb-8\">
    Complétez votre formation de plongeur avec nos spécialisations avancées et formations de sécurité.
</p>

<div class=\"grid gap-8\">
    <div class=\"bg-white border border-gray-200 rounded-lg overflow-hidden shadow-md\">
        <div class=\"bg-gradient-to-r from-green-500 to-green-600 p-4\">
            <h2 class=\"text-xl font-semibold text-white flex items-center\">
                <span class=\"mr-2\">🫧</span>
                Formations Nitrox
            </h2>
        </div>
        <div class=\"p-6\">
            <div class=\"grid md:grid-cols-2 gap-6\">
                <div>
                    <h3 class=\"font-semibold text-green-700 mb-3\">Nitrox Élémentaire</h3>
                    <ul class=\"space-y-2 text-sm\">
                        <li class=\"flex items-center\">
                            <span class=\"text-green-500 mr-2\">•</span>
                            Plongée avec mélange à 40% d\'oxygène
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-green-500 mr-2\">•</span>
                            Plongées moins fatigantes
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-green-500 mr-2\">•</span>
                            Plus de sécurité
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-green-500 mr-2\">•</span>
                            Consommation d\'air réduite
                        </li>
                    </ul>
                    <p class=\"text-sm text-gray-600 mt-3\">
                        <strong>Recommandé :</strong> Plongées vers 30m de profondeur
                    </p>
                </div>
                <div>
                    <h3 class=\"font-semibold text-green-700 mb-3\">Nitrox Confirmé</h3>
                    <ul class=\"space-y-2 text-sm\">
                        <li class=\"flex items-center\">
                            <span class=\"text-green-500 mr-2\">•</span>
                            Choix du pourcentage d\'oxygène
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-green-500 mr-2\">•</span>
                            Utilisation d\'oxygène pur aux paliers
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-green-500 mr-2\">•</span>
                            Décompression optimisée
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class=\"bg-white border border-gray-200 rounded-lg overflow-hidden shadow-md\">
        <div class=\"bg-gradient-to-r from-red-500 to-red-600 p-4\">
            <h2 class=\"text-xl font-semibold text-white flex items-center\">
                <span class=\"mr-2\">🆘</span>
                RIFAP - Secours et Sauvetage
            </h2>
        </div>
        <div class=\"p-6\">
            <div class=\"grid md:grid-cols-2 gap-6\">
                <div>
                    <h3 class=\"font-semibold text-red-700 mb-3\">Compétences enseignées</h3>
                    <ul class=\"space-y-2 text-sm\">
                        <li class=\"flex items-center\">
                            <span class=\"text-red-500 mr-2\">•</span>
                            Techniques de sauvetage
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-red-500 mr-2\">•</span>
                            Remontée de plongeur inconscient
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-red-500 mr-2\">•</span>
                            Administration d\'oxygène médical
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-red-500 mr-2\">•</span>
                            Utilisation radio de base
                        </li>
                    </ul>
                </div>
                <div>
                    <div class=\"bg-red-50 p-4 rounded-lg\">
                        <h4 class=\"font-semibold text-red-800 mb-2\">⚠️ Obligatoire pour :</h4>
                        <ul class=\"text-sm text-red-700 space-y-1\">
                            <li>• Niveau 3</li>
                            <li>• Niveau 4 / Guide de palanquée</li>
                            <li>• Moniteurs</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class=\"mt-4 p-3 bg-yellow-50 rounded border-l-4 border-yellow-400\">
                <p class=\"text-sm text-yellow-800\">
                    <strong>Recyclage :</strong> Sessions périodiques de remise à niveau et sensibilisation au secours
                </p>
            </div>
        </div>
    </div>

    <div class=\"bg-white border border-gray-200 rounded-lg overflow-hidden shadow-md\">
        <div class=\"bg-gradient-to-r from-purple-500 to-purple-600 p-4\">
            <h2 class=\"text-xl font-semibold text-white flex items-center\">
                <span class=\"mr-2\">🎓</span>
                Formations Moniteur
            </h2>
        </div>
        <div class=\"p-6\">
            <div class=\"grid md:grid-cols-2 gap-6\">
                <div>
                    <h3 class=\"font-semibold text-purple-700 mb-3\">Initiateur</h3>
                    <p class=\"text-sm text-gray-600 mb-2\">
                        Premier niveau d\'enseignement pour former les plongeurs débutants
                    </p>
                    <ul class=\"space-y-1 text-sm\">
                        <li class=\"flex items-center\">
                            <span class=\"text-purple-500 mr-2\">•</span>
                            Formation départementale
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-purple-500 mr-2\">•</span>
                            Enseigne en milieu protégé
                        </li>
                    </ul>
                </div>
                <div>
                    <h3 class=\"font-semibold text-purple-700 mb-3\">Moniteur Fédéral</h3>
                    <p class=\"text-sm text-gray-600 mb-2\">
                        Formation complète pour l\'enseignement tous niveaux
                    </p>
                    <ul class=\"space-y-1 text-sm\">
                        <li class=\"flex items-center\">
                            <span class=\"text-purple-500 mr-2\">•</span>
                            Formation régionale
                        </li>
                        <li class=\"flex items-center\">
                            <span class=\"text-purple-500 mr-2\">•</span>
                            Toutes prérogatives d\'enseignement
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<div class=\"bg-club-orange-light p-6 rounded-lg mt-8\">
    <h3 class=\"text-lg font-semibold mb-4\">🎯 Poursuivez votre formation !</h3>
    <p class=\"mb-4\">
        Ces formations spécialisées vous permettront d\'enrichir votre pratique de la plongée et d\'acquérir de nouvelles compétences.
    </p>
    <div class=\"flex gap-3\">
        <a href=\"/contact\" class=\"bg-club-orange text-white px-4 py-2 rounded hover:bg-club-orange-dark\">
            Me renseigner
        </a>
        <a href=\"/calendrier\" class=\"border border-club-orange text-club-orange px-4 py-2 rounded hover:bg-club-orange hover:text-white\">
            Voir le planning
        </a>
    </div>
</div>
</div>','pages/page.html.twig','page','published',NULL,'Autres formations - Club Subaquatique des Vénètes','Formations spécialisées plongée : Nitrox, RIFAP secours, formations Moniteur au Club des Vénètes.','[\"formation\", \"nitrox\", \"RIFAP\", \"moniteur\", \"spécialisation\"]',NULL,NOW(),NOW(),0,0),
(6,1,'Plongeurs extérieurs','plongeurs-exterieurs','Rejoignez nos sorties plongée ! 25€/plongée ou 100€ les 5. Documents requis : licence FFESSM, niveau, certificat médical.','<div class=\"prose max-w-none\">
<h1>Plongeurs extérieurs</h1>

<div class=\"bg-blue-50 border-l-4 border-blue-400 p-6 mb-8\">
    <h2 class=\"text-xl font-semibold text-blue-800 mb-2\">Bienvenue aux plongeurs extérieurs !</h2>
    <p class=\"text-blue-700\">
        Rejoignez nos sorties plongée et découvrez les sites exceptionnels du Golfe du Morbihan
    </p>
</div>

<div class=\"grid md:grid-cols-2 gap-8\">
    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Documents requis</h2>
        <div class=\"space-y-3\">
            <div class=\"flex items-center p-3 bg-orange-50 rounded border-l-4 border-orange-400\">
                <svg class=\"w-6 h-6 text-orange-500 mr-3\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path d=\"M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.031 9-11.622 0-1.042-.133-2.052-.382-3.016z\"/>
                </svg>
                <div>
                    <p class=\"font-semibold\">Licence FFESSM</p>
                    <p class=\"text-sm text-gray-600\">Le club peut en fournir une si nécessaire</p>
                </div>
            </div>

            <div class=\"flex items-center p-3 bg-green-50 rounded border-l-4 border-green-400\">
                <svg class=\"w-6 h-6 text-green-500 mr-3\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path fill-rule=\"evenodd\" d=\"M10 2a4 4 0 00-4 4v1H5a1 1 0 00-.994.89l-1 9A1 1 0 004 18h12a1 1 0 00.994-1.11l-1-9A1 1 0 0015 7h-1V6a4 4 0 00-4-4zM8 6a2 2 0 114 0v1H8V6z\" clip-rule=\"evenodd\"/>
                </svg>
                <div>
                    <p class=\"font-semibold\">Carte de niveau</p>
                    <p class=\"text-sm text-gray-600\">Justificatif de votre niveau de plongée</p>
                </div>
            </div>

            <div class=\"flex items-center p-3 bg-red-50 rounded border-l-4 border-red-400\">
                <svg class=\"w-6 h-6 text-red-500 mr-3\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                    <path fill-rule=\"evenodd\" d=\"M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z\" clip-rule=\"evenodd\"/>
                </svg>
                <div>
                    <p class=\"font-semibold\">Certificat médical</p>
                    <p class=\"text-sm text-gray-600\">De moins d\'un an</p>
                </div>
            </div>
        </div>
    </div>

    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Tarifs</h2>
        <div class=\"space-y-4\">
            <div class=\"bg-white border-2 border-club-orange rounded-lg p-6 text-center\">
                <div class=\"text-3xl font-bold text-club-orange mb-2\">25€</div>
                <p class=\"text-gray-600\">par plongée</p>
            </div>

            <div class=\"bg-club-orange text-white rounded-lg p-6 text-center\">
                <div class=\"text-3xl font-bold mb-2\">100€</div>
                <p class=\"text-orange-100\">forfait 5 plongées</p>
                <div class=\"text-sm mt-2 bg-orange-600 rounded px-2 py-1 inline-block\">
                    Économie de 25€
                </div>
            </div>
        </div>
    </div>
</div>

<div class=\"mt-8\">
    <h2 class=\"text-xl font-semibold mb-6\">Comment s\'inscrire ?</h2>

    <div class=\"grid md:grid-cols-3 gap-6\">
        <div class=\"text-center\">
            <div class=\"bg-club-orange text-white rounded-full w-12 h-12 flex items-center justify-center mx-auto mb-3 text-xl font-bold\">1</div>
            <h3 class=\"font-semibold mb-2\">Consultez le calendrier</h3>
            <p class=\"text-sm text-gray-600\">
                Vérifiez les plongées organisées sur le calendrier d\'accueil. Les dates en orange indiquent une plongée prévue.
            </p>
        </div>

        <div class=\"text-center\">
            <div class=\"bg-club-orange text-white rounded-full w-12 h-12 flex items-center justify-center mx-auto mb-3 text-xl font-bold\">2</div>
            <h3 class=\"font-semibold mb-2\">Cliquez sur la date</h3>
            <p class=\"text-sm text-gray-600\">
                Découvrez le nom du responsable, l\'heure de départ, la description et les places disponibles.
            </p>
        </div>

        <div class=\"text-center\">
            <div class=\"bg-club-orange text-white rounded-full w-12 h-12 flex items-center justify-center mx-auto mb-3 text-xl font-bold\">3</div>
            <h3 class=\"font-semibold mb-2\">Envoyez un email</h3>
            <p class=\"text-sm text-gray-600\">
                Contactez-nous à l\'adresse indiquée pour réserver votre place.
            </p>
        </div>
    </div>
</div>

<div class=\"bg-gray-50 p-6 rounded-lg mt-8\">
    <h2 class=\"text-xl font-semibold mb-4\">Matériel fourni par le club</h2>
    <div class=\"grid md:grid-cols-2 gap-6\">
        <div>
            <h3 class=\"font-semibold text-green-700 mb-3\">✅ Inclus</h3>
            <ul class=\"space-y-2 text-sm\">
                <li class=\"flex items-center\">
                    <span class=\"text-green-500 mr-2\">•</span>
                    Bouteille de plongée
                </li>
                <li class=\"flex items-center\">
                    <span class=\"text-green-500 mr-2\">•</span>
                    Gilet stabilisateur
                </li>
                <li class=\"flex items-center\">
                    <span class=\"text-green-500 mr-2\">•</span>
                    Détendeurs
                </li>
            </ul>
        </div>

        <div>
            <h3 class=\"font-semibold text-red-700 mb-3\">❌ Non fourni</h3>
            <ul class=\"space-y-2 text-sm\">
                <li class=\"flex items-center\">
                    <span class=\"text-red-500 mr-2\">•</span>
                    Combinaison de plongée
                </li>
                <li class=\"flex items-center\">
                    <span class=\"text-gray-500 mr-2\">•</span>
                    <span class=\"text-gray-600\">À prévoir personnellement</span>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class=\"bg-blue-50 p-6 rounded-lg mt-8\">
    <h2 class=\"text-xl font-semibold mb-4\">Déroulement d\'une sortie</h2>
    <div class=\"space-y-3 text-sm\">
        <div class=\"flex items-start\">
            <span class=\"bg-blue-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs mr-3 mt-0.5\">1</span>
            <div>
                <strong>Rendez-vous au club</strong> 30 minutes avant l\'heure programmée
            </div>
        </div>
        <div class=\"flex items-start\">
            <span class=\"bg-blue-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs mr-3 mt-0.5\">2</span>
            <div>
                <strong>Vérification des documents</strong> par le directeur de plongée
            </div>
        </div>
        <div class=\"flex items-start\">
            <span class=\"bg-blue-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs mr-3 mt-0.5\">3</span>
            <div>
                <strong>Destinations typiques :</strong> Larmor Baden, Ria d\'Etel, Lorient/Groix
            </div>
        </div>
        <div class=\"flex items-start\">
            <span class=\"bg-blue-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs mr-3 mt-0.5\">4</span>
            <div>
                <strong>Retour au club</strong> pour rincer et ranger le matériel
            </div>
        </div>
    </div>
</div>

<div class=\"bg-club-orange-light p-6 rounded-lg mt-8\">
    <h3 class=\"text-lg font-semibold mb-4\">🤿 Prêt à plonger avec nous ?</h3>
    <p class=\"mb-4\">
        Rejoignez nos sorties et découvrez les merveilles sous-marines du Golfe du Morbihan !
    </p>
    <div class=\"flex gap-3\">
        <a href=\"/calendrier\" class=\"bg-club-orange text-white px-4 py-2 rounded hover:bg-club-orange-dark\">
            Voir le calendrier
        </a>
        <a href=\"/contact\" class=\"border border-club-orange text-club-orange px-4 py-2 rounded hover:bg-club-orange hover:text-white\">
            Nous contacter
        </a>
    </div>
</div>
</div>','pages/page.html.twig','page','published',NULL,'Plongeurs extérieurs - Club Subaquatique des Vénètes','Plongeurs extérieurs bienvenus ! Tarifs : 25€/plongée. Matériel fourni. Sorties Golfe du Morbihan, Ria d\'Etel.','[\"plongeurs extérieurs\", \"tarifs\", \"sorties\", \"matériel\"]',NULL,NOW(),NOW(),0,0),
(7,1,'Apnée','apnee','Section apnée du CSV : 50 membres, 3 créneaux hebdomadaires à Elven. Formations du Pass\' Apnéiste à Expert.','<div class=\"prose max-w-none\">
<h1>Section Apnée</h1>

<div class=\"bg-gradient-to-r from-cyan-500 to-blue-500 text-white p-6 rounded-lg mb-8\">
    <h2 class=\"text-2xl font-semibold mb-2\">🫁 Découvrez l\'apnée au CSV</h2>
    <p class=\"text-cyan-100\">Environ 50 membres pratiquent l\'apnée dans notre section dédiée</p>
</div>

<div class=\"bg-red-50 border-l-4 border-red-400 p-4 mb-8\">
    <div class=\"flex\">
        <div class=\"flex-shrink-0\">
            <svg class=\"h-5 w-5 text-red-400\" viewBox=\"0 0 20 20\" fill=\"currentColor\">
                <path fill-rule=\"evenodd\" d=\"M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z\" clip-rule=\"evenodd\" />
            </svg>
        </div>
        <div class=\"ml-3\">
            <p class=\"text-sm text-red-700\">
                <strong>Section complète pour l\'année 2025-2026</strong><br>
                Les inscriptions sont fermées pour cette saison.
            </p>
        </div>
    </div>
</div>

<div class=\"grid md:grid-cols-2 gap-8\">
    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Entraînements</h2>

        <div class=\"space-y-4\">
            <div class=\"bg-white border border-gray-200 rounded-lg p-4\">
                <div class=\"flex items-center justify-between mb-2\">
                    <h3 class=\"font-semibold text-blue-700\">Jeudi</h3>
                    <span class=\"bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded\">Principal</span>
                </div>
                <p class=\"text-sm text-gray-600 mb-1\">21h00 - 22h30</p>
                <p class=\"text-sm text-gray-500\">Septembre à juin</p>
                <p class=\"text-sm font-medium mt-2\">Piscine d\'Elven</p>
            </div>

            <div class=\"bg-white border border-gray-200 rounded-lg p-4\">
                <div class=\"flex items-center justify-between mb-2\">
                    <h3 class=\"font-semibold text-green-700\">Mercredi</h3>
                    <span class=\"bg-green-100 text-green-800 text-xs px-2 py-1 rounded\">Avancé</span>
                </div>
                <p class=\"text-sm text-gray-600 mb-1\">19h45 - 21h30</p>
                <p class=\"text-sm text-gray-500\">Hors débutants</p>
                <p class=\"text-sm font-medium mt-2\">Piscine d\'Elven</p>
            </div>

            <div class=\"bg-white border border-gray-200 rounded-lg p-4\">
                <div class=\"flex items-center justify-between mb-2\">
                    <h3 class=\"font-semibold text-orange-700\">Lundi</h3>
                    <span class=\"bg-orange-100 text-orange-800 text-xs px-2 py-1 rounded\">Compétition</span>
                </div>
                <p class=\"text-sm text-gray-600 mb-1\">20h00 - 21h30</p>
                <p class=\"text-sm text-gray-500\">Compétiteurs uniquement</p>
                <p class=\"text-sm font-medium mt-2\">Piscine d\'Elven</p>
            </div>
        </div>
    </div>

    <div>
        <h2 class=\"text-xl font-semibold mb-4\">Formation</h2>

        <div class=\"space-y-4\">
            <div class=\"bg-cyan-50 p-4 rounded-lg\">
                <h3 class=\"font-semibold text-cyan-800 mb-3\">Encadrement qualifié</h3>
                <ul class=\"text-sm text-cyan-700 space-y-1\">
                    <li>• Moniteurs IE1 à MEF1</li>
                    <li>• Techniques statiques et dynamiques</li>
                    <li>• Apnée bi-palmes, mono-palme, sans palmes</li>
                </ul>
            </div>

            <div class=\"bg-blue-50 p-4 rounded-lg\">
                <h3 class=\"font-semibold text-blue-800 mb-3\">Niveaux proposés</h3>
                <ul class=\"text-sm text-blue-700 space-y-1\">
                    <li>• Pass\' Apnéiste (débutant)</li>
                    <li>• Apnéiste Bronze, Argent, Or</li>
                    <li>• Apnéiste Expert Eau Libre</li>
                </ul>
            </div>
        </div>

        <h3 class=\"text-lg font-semibold mt-6 mb-4\">Matériel requis</h3>
        <div class=\"bg-gray-50 p-4 rounded-lg\">
            <h4 class=\"font-semibold mb-2\">Équipement minimum :</h4>
            <ul class=\"text-sm space-y-1\">
                <li class=\"flex items-center\">
                    <span class=\"text-blue-500 mr-2\">•</span>
                    Palmes
                </li>
                <li class=\"flex items-center\">
                    <span class=\"text-blue-500 mr-2\">•</span>
                    Masque
                </li>
                <li class=\"flex items-center\">
                    <span class=\"text-blue-500 mr-2\">•</span>
                    Tuba
                </li>
                <li class=\"flex items-center\">
                    <span class=\"text-blue-500 mr-2\">•</span>
                    Lestage
                </li>
            </ul>
        </div>
    </div>
</div>

<div class=\"mt-8\">
    <h2 class=\"text-xl font-semibold mb-6\">Activités spéciales</h2>

    <div class=\"grid md:grid-cols-2 gap-6\">
        <div class=\"bg-white border border-gray-200 rounded-lg p-6\">
            <h3 class=\"font-semibold text-purple-700 mb-3\">🏊‍♀️ Sessions fosse</h3>
            <p class=\"text-sm text-gray-600\">
                Entraînements en profondeur dans des fosses spécialisées pour travailler l\'apnée en profondeur.
            </p>
        </div>

        <div class=\"bg-white border border-gray-200 rounded-lg p-6\">
            <h3 class=\"font-semibold text-green-700 mb-3\">🌊 Milieu naturel</h3>
            <p class=\"text-sm text-gray-600\">
                Sorties en mer pour pratiquer l\'apnée dans des conditions réelles.
            </p>
        </div>

        <div class=\"bg-white border border-gray-200 rounded-lg p-6\">
            <h3 class=\"font-semibold text-red-700 mb-3\">🆘 Ateliers sécurité</h3>
            <p class=\"text-sm text-gray-600\">
                Formation aux techniques de sécurité spécifiques à l\'apnée.
            </p>
        </div>

        <div class=\"bg-white border border-gray-200 rounded-lg p-6\">
            <h3 class=\"font-semibold text-yellow-700 mb-3\">🧘‍♀️ Initiation yoga</h3>
            <p class=\"text-sm text-gray-600\">
                Techniques de relaxation et de respiration pour améliorer les performances.
            </p>
        </div>

        <div class=\"bg-white border border-gray-200 rounded-lg p-6\">
            <h3 class=\"font-semibold text-blue-700 mb-3\">🏊‍♂️ Mono-palme</h3>
            <p class=\"text-sm text-gray-600\">
                Initiation et perfectionnement à la technique mono-palme.
            </p>
        </div>
    </div>
</div>

<div class=\"bg-club-orange-light p-6 rounded-lg mt-8\">
    <h3 class=\"text-lg font-semibold mb-4\">🌊 Rejoignez-nous la saison prochaine !</h3>
    <p class=\"mb-4\">
        La section apnée est complète cette année, mais n\'hésitez pas à nous contacter pour être informé des ouvertures pour la saison 2026-2027.
    </p>
    <div class=\"flex gap-3\">
        <a href=\"/contact\" class=\"bg-club-orange text-white px-4 py-2 rounded hover:bg-club-orange-dark\">
            Nous contacter
        </a>
        <a href=\"/calendrier\" class=\"border border-club-orange text-club-orange px-4 py-2 rounded hover:bg-club-orange hover:text-white\">
            Voir les activités
        </a>
    </div>
</div>
</div>','pages/page.html.twig','page','published',NULL,'Apnée - Club Subaquatique des Vénètes','Section apnée CSV : entraînements Elven, niveaux Pass\' Apnéiste à Expert, encadrement qualifié IE1-MEF1.','[\"apnée\", \"entraînement\", \"piscine\", \"Elven\", \"compétition\"]',NULL,NOW(),NOW(),0,0),
(8,1,'La piscine','la-piscine','Entraînements piscine dans nos 3 sites : Kercado, Elven, Grandchamp. Formations N1, N2, GP et apnée.','<div class=\"prose max-w-none\">
<h1>Activités Piscine</h1>

<div class=\"bg-gradient-to-r from-blue-500 to-indigo-600 text-white p-6 rounded-lg mb-8\">
    <h2 class=\"text-2xl font-semibold mb-2\">🏊‍♀️ Entraînements en piscine</h2>
    <p class=\"text-blue-100\">Formations et perfectionnement technique dans nos trois piscines partenaires</p>
</div>

<div class=\"grid md:grid-cols-3 gap-6 mb-8\">
    <div class=\"bg-white border-2 border-blue-200 rounded-lg p-6 text-center\">
        <div class=\"bg-blue-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4\">
            <svg class=\"w-8 h-8 text-blue-600\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                <path fill-rule=\"evenodd\" d=\"M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z\" clip-rule=\"evenodd\"/>
            </svg>
        </div>
        <h3 class=\"text-lg font-semibold text-blue-700\">Kercado</h3>
        <p class=\"text-sm text-gray-600 mt-2\">Piscine municipale de Vannes</p>
    </div>

    <div class=\"bg-white border-2 border-green-200 rounded-lg p-6 text-center\">
        <div class=\"bg-green-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4\">
            <svg class=\"w-8 h-8 text-green-600\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                <path fill-rule=\"evenodd\" d=\"M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z\" clip-rule=\"evenodd\"/>
            </svg>
        </div>
        <h3 class=\"text-lg font-semibold text-green-700\">Elven</h3>
        <p class=\"text-sm text-gray-600 mt-2\">Piscine intercommunale</p>
    </div>

    <div class=\"bg-white border-2 border-purple-200 rounded-lg p-6 text-center\">
        <div class=\"bg-purple-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4\">
            <svg class=\"w-8 h-8 text-purple-600\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                <path fill-rule=\"evenodd\" d=\"M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z\" clip-rule=\"evenodd\"/>
            </svg>
        </div>
        <h3 class=\"text-lg font-semibold text-purple-700\">Grandchamp</h3>
        <p class=\"text-sm text-gray-600 mt-2\">Piscine du lycée</p>
    </div>
</div>

<div class=\"grid md:grid-cols-2 gap-8\">
    <div>
        <h2 class=\"text-xl font-semibold mb-6\">Types d\'entraînements</h2>

        <div class=\"space-y-4\">
            <div class=\"bg-blue-50 border-l-4 border-blue-400 p-4\">
                <h3 class=\"font-semibold text-blue-800\">Formation Niveau 1</h3>
                <p class=\"text-sm text-blue-700 mt-1\">
                    Apprentissage des bases : respiration au détendeur, vidage de masque, stabilisation
                </p>
                <div class=\"mt-2 text-xs text-blue-600\">
                    📅 Octobre à mai
                </div>
            </div>

            <div class=\"bg-green-50 border-l-4 border-green-400 p-4\">
                <h3 class=\"font-semibold text-green-800\">Formation Niveau 2</h3>
                <p class=\"text-sm text-green-700 mt-1\">
                    Techniques avancées : remontée assistée, navigation, autonomie
                </p>
                <div class=\"mt-2 text-xs text-green-600\">
                    📅 Octobre-novembre et avril-mai
                </div>
            </div>

            <div class=\"bg-purple-50 border-l-4 border-purple-400 p-4\">
                <h3 class=\"font-semibold text-purple-800\">Guide de palanquée</h3>
                <p class=\"text-sm text-purple-700 mt-1\">
                    Formation d\'encadrant : sauvetage, organisation, pédagogie
                </p>
                <div class=\"mt-2 text-xs text-purple-600\">
                    📅 Octobre à mai
                </div>
            </div>

            <div class=\"bg-cyan-50 border-l-4 border-cyan-400 p-4\">
                <h3 class=\"font-semibold text-cyan-800\">Apnée</h3>
                <p class=\"text-sm text-cyan-700 mt-1\">
                    Statique, dynamique, techniques bi-palmes et mono-palme
                </p>
                <div class=\"mt-2 text-xs text-cyan-600\">
                    📅 Septembre à juin
                </div>
            </div>
        </div>
    </div>

    <div>
        <h2 class=\"text-xl font-semibold mb-6\">Organisation des séances</h2>

        <div class=\"space-y-6\">
            <div class=\"bg-white border border-gray-200 rounded-lg p-6\">
                <h3 class=\"font-semibold mb-4 text-gray-800\">🕐 Créneaux horaires</h3>
                <div class=\"space-y-2 text-sm\">
                    <div class=\"flex justify-between items-center p-2 bg-gray-50 rounded\">
                        <span class=\"font-medium\">Mardi</span>
                        <span class=\"text-gray-600\">20h00 - 22h00</span>
                    </div>
                    <div class=\"flex justify-between items-center p-2 bg-gray-50 rounded\">
                        <span class=\"font-medium\">Jeudi</span>
                        <span class=\"text-gray-600\">20h00 - 22h00</span>
                    </div>
                    <div class=\"flex justify-between items-center p-2 bg-gray-50 rounded\">
                        <span class=\"font-medium\">Samedi</span>
                        <span class=\"text-gray-600\">14h00 - 16h00</span>
                    </div>
                </div>
                <p class=\"text-xs text-gray-500 mt-3\">
                    Horaires détaillés disponibles selon les piscines
                </p>
            </div>

            <div class=\"bg-orange-50 border border-orange-200 rounded-lg p-6\">
                <h3 class=\"font-semibold mb-3 text-orange-800\">👥 Encadrement</h3>
                <ul class=\"text-sm text-orange-700 space-y-1\">
                    <li>• Moniteurs FFESSM qualifiés</li>
                    <li>• Guides de palanquée expérimentés</li>
                    <li>• Adaptation aux niveaux de chacun</li>
                    <li>• Groupes de 4-6 plongeurs maximum</li>
                </ul>
            </div>

            <div class=\"bg-yellow-50 border border-yellow-200 rounded-lg p-6\">
                <h3 class=\"font-semibold mb-3 text-yellow-800\">🎯 Objectifs</h3>
                <ul class=\"text-sm text-yellow-700 space-y-1\">
                    <li>• Maîtrise technique en milieu protégé</li>
                    <li>• Préparation aux plongées en mer</li>
                    <li>• Perfectionnement des gestes</li>
                    <li>• Condition physique et aisance aquatique</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class=\"bg-club-orange-light p-6 rounded-lg mt-8\">
    <h3 class=\"text-lg font-semibold mb-4\">💧 L\'étape essentielle de votre formation</h3>
    <p class=\"mb-4\">
        La piscine est le lieu idéal pour acquérir et perfectionner les techniques de plongée en toute sécurité, avant de découvrir les merveilles sous-marines en milieu naturel.
    </p>
    <div class=\"flex gap-3\">
        <a href=\"/formation-niveau-1\" class=\"bg-club-orange text-white px-4 py-2 rounded hover:bg-club-orange-dark\">
            Commencer ma formation
        </a>
        <a href=\"/contact\" class=\"border border-club-orange text-club-orange px-4 py-2 rounded hover:bg-club-orange hover:text-white\">
            Plus d\'infos
        </a>
    </div>
</div>
</div>','pages/page.html.twig','page','published',NULL,'La piscine - Club Subaquatique des Vénètes','Entraînements piscine CSV : Kercado, Elven, Grandchamp. Formations plongée et apnée avec moniteurs qualifiés.','[\"piscine\", \"formation\", \"entraînement\", \"technique\"]',NULL,NOW(),NOW(),0,0),
(9,1,'Station de gonflage','gonflage','Station de gonflage Nitrox/Trimix. Air €0.002/L, O₂ €0.02/L, He €0.042/L. Contact : Claudio 06 75 75 48 26.','<div class=\"prose max-w-none\">
<h1>Station de gonflage</h1>

<div class=\"bg-gradient-to-r from-gray-600 to-gray-800 text-white p-6 rounded-lg mb-8\">
    <h2 class=\"text-2xl font-semibold mb-2\">⚗️ Station Nitrox et Trimix</h2>
    <p class=\"text-gray-100\">Service de gonflage professionnel ouvert aux plongeurs extérieurs qualifiés</p>
</div>

<div class=\"grid md:grid-cols-2 gap-8\">
    <div>
        <h2 class=\"text-xl font-semibold mb-6\">Services proposés</h2>

        <div class=\"space-y-4\">
            <div class=\"bg-blue-50 border-l-4 border-blue-400 p-4\">
                <h3 class=\"font-semibold text-blue-800 flex items-center\">
                    <span class=\"mr-2\">💨</span>
                    Air comprimé
                </h3>
                <p class=\"text-sm text-blue-700 mt-1\">
                    Gonflage air standard pour toutes vos plongées
                </p>
                <div class=\"mt-2 text-xs text-blue-600 font-medium\">
                    €0.002 / litre
                </div>
            </div>

            <div class=\"bg-green-50 border-l-4 border-green-400 p-4\">
                <h3 class=\"font-semibold text-green-800 flex items-center\">
                    <span class=\"mr-2\">🫧</span>
                    Nitrox
                </h3>
                <p class=\"text-sm text-green-700 mt-1\">
                    Mélanges enrichis en oxygène pour plongées plus sûres
                </p>
                <div class=\"mt-2 text-xs text-green-600 font-medium\">
                    Seules les bouteilles Nitrox autorisées
                </div>
            </div>

            <div class=\"bg-yellow-50 border-l-4 border-yellow-400 p-4\">
                <h3 class=\"font-semibold text-yellow-800 flex items-center\">
                    <span class=\"mr-2\">⚡</span>
                    Trimix
                </h3>
                <p class=\"text-sm text-yellow-700 mt-1\">
                    Mélanges ternaires pour plongées techniques profondes
                </p>
                <div class=\"mt-2 text-xs text-yellow-600 font-medium\">
                    Pour plongeurs techniques qualifiés
                </div>
            </div>
        </div>

        <h3 class=\"text-lg font-semibold mt-8 mb-4\">Conditions d\'accès</h3>
        <div class=\"bg-orange-50 p-4 rounded-lg\">
            <ul class=\"text-sm space-y-2\">
                <li class=\"flex items-center\">
                    <svg class=\"w-4 h-4 text-orange-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                        <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                    </svg>
                    <span>Plongeurs extérieurs qualifiés</span>
                </li>
                <li class=\"flex items-center\">
                    <svg class=\"w-4 h-4 text-orange-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                        <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                    </svg>
                    <span>Licence FFESSM en cours de validité</span>
                </li>
                <li class=\"flex items-center\">
                    <svg class=\"w-4 h-4 text-orange-500 mr-2\" fill=\"currentColor\" viewBox=\"0 0 20 20\">
                        <path fill-rule=\"evenodd\" d=\"M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z\" clip-rule=\"evenodd\"></path>
                    </svg>
                    <span>Qualification Nitrox/Trimix selon besoins</span>
                </li>
            </ul>
        </div>
    </div>

    <div>
        <h2 class=\"text-xl font-semibold mb-6\">Tarification</h2>

        <div class=\"space-y-4\">
            <div class=\"bg-white border border-gray-200 rounded-lg p-4\">
                <h3 class=\"font-semibold mb-3\">Gaz de base (par litre)</h3>
                <div class=\"space-y-2\">
                    <div class=\"flex justify-between items-center p-2 bg-gray-50 rounded\">
                        <span class=\"font-medium\">Air</span>
                        <span class=\"text-green-600 font-bold\">€0.002</span>
                    </div>
                    <div class=\"flex justify-between items-center p-2 bg-orange-50 rounded\">
                        <span class=\"font-medium\">Oxygène</span>
                        <span class=\"text-orange-600 font-bold\">€0.02</span>
                    </div>
                    <div class=\"flex justify-between items-center p-2 bg-yellow-50 rounded\">
                        <span class=\"font-medium\">Hélium</span>
                        <span class=\"text-yellow-600 font-bold\">€0.042</span>
                    </div>
                </div>
            </div>

            <div class=\"bg-blue-50 border border-blue-200 rounded-lg p-4\">
                <h3 class=\"font-semibold mb-3\">Exemples de gonflage</h3>
                <div class=\"space-y-2 text-sm\">
                    <div class=\"flex justify-between\">
                        <span>15L 220b Nx32</span>
                        <span class=\"font-semibold\">€15</span>
                    </div>
                    <div class=\"flex justify-between\">
                        <span>15L 220b Nx36</span>
                        <span class=\"font-semibold\">€18</span>
                    </div>
                    <div class=\"flex justify-between\">
                        <span>7L 200b O₂</span>
                        <span class=\"font-semibold\">€28</span>
                    </div>
                    <div class=\"flex justify-between\">
                        <span>S80 (11.1L) 200b Nx50</span>
                        <span class=\"font-semibold\">€19</span>
                    </div>
                </div>
            </div>

            <div class=\"bg-red-50 border border-red-200 rounded-lg p-4\">
                <h3 class=\"font-semibold mb-3\">Mélanges Trimix</h3>
                <div class=\"space-y-2 text-sm\">
                    <div class=\"flex justify-between\">
                        <span>15L 220b Tx18/40</span>
                        <span class=\"font-semibold\">€63.50</span>
                    </div>
                    <div class=\"flex justify-between\">
                        <span>2x12L 220b Tx18/40</span>
                        <span class=\"font-semibold\">€101.50</span>
                    </div>
                </div>
                <p class=\"text-xs text-red-600 mt-2\">
                    Tarifs incluant hélium, oxygène et analyse
                </p>
            </div>
        </div>

        <div class=\"bg-gray-100 p-4 rounded-lg mt-6\">
            <h3 class=\"font-semibold mb-2 text-gray-800\">📞 Contact</h3>
            <div class=\"text-sm\">
                <p class=\"font-medium\">Claudio Pascual</p>
                <p class=\"text-gray-600\">Responsable station de gonflage</p>
                <p class=\"text-blue-600 font-medium\">06 75 75 48 26</p>
            </div>
        </div>
    </div>
</div>

<div class=\"bg-yellow-50 border-l-4 border-yellow-400 p-6 mt-8\">
    <h3 class=\"font-semibold mb-3 text-yellow-800\">⚙️ Équipement professionnel</h3>
    <div class=\"grid md:grid-cols-2 gap-4 text-sm\">
        <div>
            <h4 class=\"font-semibold mb-2\">Matériel de mélange</h4>
            <ul class=\"space-y-1 text-yellow-700\">
                <li>• Compresseurs haute pression</li>
                <li>• Système de mélange automatisé</li>
                <li>• Analyseurs O₂ et He</li>
            </ul>
        </div>
        <div>
            <h4 class=\"font-semibold mb-2\">Contrôle qualité</h4>
            <ul class=\"space-y-1 text-yellow-700\">
                <li>• Analyse systématique des mélanges</li>
                <li>• Traçabilité des gonflages</li>
                <li>• Maintenance préventive régulière</li>
            </ul>
        </div>
    </div>
</div>

<div class=\"bg-club-orange-light p-6 rounded-lg mt-8\">
    <h3 class=\"text-lg font-semibold mb-4\">⚗️ Service professionnel de gonflage</h3>
    <p class=\"mb-4\">
        Notre station équipée vous propose des mélanges gazeux de qualité pour toutes vos plongées, du loisir à la plongée technique.
    </p>
    <div class=\"flex gap-3\">
        <a href=\"tel:0675754826\" class=\"bg-club-orange text-white px-4 py-2 rounded hover:bg-club-orange-dark\">
            Contacter Claudio
        </a>
        <a href=\"/contact\" class=\"border border-club-orange text-club-orange px-4 py-2 rounded hover:bg-club-orange hover:text-white\">
            Infos générales
        </a>
    </div>
</div>
</div>','pages/page.html.twig','page','published',NULL,'Station de gonflage - Club Subaquatique des Vénètes','Station gonflage Nitrox/Trimix CSV. Tarifs compétitifs, équipement professionnel. Contact Claudio Pascual.','[\"gonflage\", \"nitrox\", \"trimix\", \"station\", \"technique\"]',NULL,NOW(),NOW(),0,0),
(10,1,'Nos activités','nos-activites','Découvrez toutes les activités proposées par le Club Subaquatique des Vénètes.','<h2>Nos activités</h2><p>Le Club Subaquatique des Vénètes propose de nombreuses activités pour tous les niveaux :</p><ul><li><strong>Plongée bouteille</strong> : explorations, formations du baptême au niveau 4</li><li><strong>Apnée</strong> : initiations et perfectionnement</li><li><strong>Sorties en mer</strong> : explorations des sites bretons</li><li><strong>Formations</strong> : passages de niveaux FFESSM</li><li><strong>Vie du club</strong> : permanences, événements conviviaux</li></ul><p>Consultez notre <a href=\"/calendrier\">calendrier</a> pour voir les prochaines sorties !</p>','pages/page.html.twig','page','published',NULL,'Nos activités - Club Subaquatique des Vénètes','Découvrez les activités du club : plongée bouteille, apnée, formations FFESSM, sorties en mer et vie associative.','[]',NULL,NOW(),NOW(),0,0);

-- Menu items
INSERT INTO `menu_item` VALUES (1,1,NULL,NULL,'Le club','dropdown',NULL,NULL,NULL,NULL,0,1,NULL,NULL,NULL,0),
(2,1,1,NULL,'Qui sommes nous','page',NULL,NULL,NULL,'👥',1,1,NULL,NULL,NULL,0),
(3,1,1,NULL,'Où nous trouver','page',NULL,NULL,NULL,'📍',2,1,NULL,NULL,NULL,0),
(4,1,1,NULL,'Tarifs Adhésion et licence 2025','page',NULL,NULL,NULL,'💰',3,1,NULL,NULL,NULL,0),
(5,1,1,NULL,'Nos partenaires','page',NULL,NULL,NULL,'🤝',4,1,NULL,NULL,NULL,0),
(6,1,NULL,NULL,'Nos activités','dropdown',NULL,NULL,NULL,NULL,5,1,NULL,'w-72',NULL,0),
(7,1,6,NULL,'Formations','dropdown',NULL,NULL,NULL,NULL,6,1,NULL,'nav-menu-header',NULL,0),
(8,1,6,1,'Niveau 1','page',NULL,NULL,NULL,'🤿',7,1,NULL,NULL,NULL,0),
(9,1,6,3,'Niveau 2 et 3','page',NULL,NULL,NULL,'🔰',8,1,NULL,NULL,NULL,0),
(10,1,6,4,'Guide de palanquée','page',NULL,NULL,NULL,'👨‍🏫',9,1,NULL,NULL,NULL,0),
(11,1,6,5,'Autres formations','page',NULL,NULL,NULL,'🎓',10,1,NULL,NULL,NULL,0),
(12,1,6,NULL,'Activités','dropdown',NULL,NULL,NULL,NULL,11,1,NULL,'nav-menu-header mt-2',NULL,0),
(13,1,6,2,'Les sorties','page',NULL,NULL,NULL,'🏊',12,1,NULL,NULL,NULL,0),
(14,1,6,6,'Plongeurs extérieurs','page',NULL,NULL,NULL,'🏊‍♂️',13,1,NULL,NULL,NULL,0),
(15,1,6,7,'Apnée','page',NULL,NULL,NULL,'🫁',14,1,NULL,NULL,NULL,0),
(16,1,6,8,'La piscine','page',NULL,NULL,NULL,'🏊‍♀️',15,1,NULL,NULL,NULL,0),
(17,1,6,9,'Gonflage','page',NULL,NULL,NULL,'🫧',16,1,NULL,NULL,NULL,0),
(18,1,NULL,NULL,'Calendrier','route','public_calendar',NULL,NULL,NULL,17,1,NULL,NULL,NULL,0),
(19,1,NULL,NULL,'Actualités','route','blog_index',NULL,NULL,NULL,18,1,NULL,NULL,NULL,0);

SET FOREIGN_KEY_CHECKS=1;
-- Articles (sans l'article test id=48)
INSERT INTO `articles` VALUES (1,1,"Quand le réveil sonne Tôt un dimanche matin de fin août…","quand-le-reveil-sonne-tot-un-dimanche-matin-de-fin-aout","<div class=\"prose max-w-none\">
<p>Certains se sont passés de grasse matinée ce dimanche et ne l\'ont pas regretté !!</p>

<p>Par Bérengère :</p>

<p>Dimanche matin, belle lumière sur le golfe, belle visibilité aux Gorêts, bancs de poissons, et petit déjeuner à bord du Fleur de Corail... Que demander de plus ?</p>

<p>Merci pour cette belle matinée !</p>

[carousel]
https://www.plongee-venetes.fr/wp-content/uploads/2025/08/matinee-gorets-1.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/08/matinee-gorets-2.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/08/matinee-gorets-3.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/08/matinee-gorets-4.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/08/matinee-gorets-5.jpg
[/carousel]
</div>","Une belle matinée de plongée aux Gorêts avec une belle lumière sur le golfe et une excellente visibilité.",NULL,"published",NOW(),NOW(),"2025-08-25 10:30:00","[]","Sorties","[\"sortie\", \"Gorêts\", \"plongée matin\", \"golfe\"]",0,NULL,NULL),
(2,1,"Plongées baptêmes à Pont Lorois 17/08/25","plongees-baptemes-a-pont-lorois-17-08-25","<div class=\"prose max-w-none\">
<p>Dimanche 17 août, Chris a organisé des plongées et baptêmes à Pont Lorois.</p>

<p>28 participants au total (plongeurs, moniteurs et baptisés) pour cette belle journée ensoleillée sur la Ria d\'Etel.</p>

<p>L\'eau était translucide et agréable !</p>
</div>","28 participants pour une belle journée de plongées et baptêmes sur la Ria d\'Etel avec une eau translucide.",NULL,"published",NOW(),NOW(),"2025-08-17 16:00:00","[]","Baptêmes","[\"baptême\", \"Pont Lorois\", \"Ria d\'Etel\", \"formation\"]",0,NULL,NULL),
(3,1,"PESH6 de René","pesh6-de-rene","<div class=\"prose max-w-none\">
<p>René a validé son premier niveau de plongée, le PESH 6 mètres au Vieux Passage à Etel.</p>

<p>La validation s\'est faite avec l\'aide de Romuald, Eric, Sébastien, Fred, Fabien et Claudio.</p>

<p>Journée magnifique et très belle visibilité !</p>

[carousel]
https://www.plongee-venetes.fr/wp-content/uploads/2025/08/pesh6-rene-1.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/08/pesh6-rene-2.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/08/pesh6-rene-3.jpg
[/carousel]
</div>","René obtient son premier niveau de plongée PESH 6 mètres au Vieux Passage à Etel.",NULL,"published",NOW(),NOW(),"2025-08-03 14:00:00","[]","Formations","[\"PESH6\", \"formation\", \"Vieux Passage\", \"Etel\"]",0,NULL,NULL),
(4,1,"Sortie à Houat","sortie-a-houat","<div class=\"prose max-w-none\">
<p>Sortie plongée du Club Subaquatique des Vénètes à l\'île de Houat le 21 juin.</p>

<p>Belle plongée avec une rencontre exceptionnelle : un phoque curieux est venu nous rendre visite !</p>

[carousel]
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/houat-1.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/houat-2.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/houat-3.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/houat-4.jpg
[/carousel]

<p>Vidéo du phoque rencontré lors de la plongée :</p>
<video controls style=\"width: 100%; max-width: 600px;\">
    <source src=\"https://www.plongee-venetes.fr/wp-content/uploads/2025/06/phoque-houat.mp4\" type=\"video/mp4\">
    Votre navigateur ne supporte pas la lecture de vidéos.
</video>
</div>","Belle sortie plongée à Houat avec une rencontre exceptionnelle avec un phoque curieux.",NULL,"published",NOW(),NOW(),"2025-06-21 18:00:00","[]","Sorties","[\"sortie\", \"Houat\", \"phoque\", \"faune marine\"]",0,NULL,NULL),
(5,1,"Plongée du soir Gorêts","plongee-du-soir-gorets","<div class=\"prose max-w-none\">
<p>C\'est l\'été au CSV et le mot d\'ordre est CONVIVIALITÉ.</p>

<p>Plongée du soir aux Gorêts avec une température de l\'eau à 19 degrés et une bonne visibilité.</p>

<p>Une des palanquées a déployé un parachute de palier au mouillage. Plongée réussie !</p>

<p>Merci à Ludovic le pilote, à Béa la mousse et aux guides de palanquée.</p>

[carousel]
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/plongee-soir-gorets-1.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/plongee-soir-gorets-2.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/plongee-soir-gorets-3.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/plongee-soir-gorets-4.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/plongee-soir-gorets-5.jpg
[/carousel]
</div>","Plongée du soir conviviale aux Gorêts avec une eau à 19°C et une bonne visibilité.",NULL,"published",NOW(),NOW(),"2025-06-15 20:30:00","[]","Sorties","[\"plongée soir\", \"Gorêts\", \"convivialité\", \"été\"]",0,NULL,NULL),
(6,1,"Handicap et plongée","handicap-et-plongee","<div class=\"prose max-w-none\">
<p>Sortie de la section Handicap du CSV.</p>

<p>René et Romuald ont été accueillis par le club d\'Etel (CNRE) pour leur première plongée mer de l\'année.</p>

<p>Une barge équipée d\'un palan et d\'un harnais a permis à René de mettre à l\'eau. Plongée au Vieux Passage avec Eric B, Seb P, Fred B, Romuald et René.</p>

<p>Vivement les prochaines aventures !</p>

<p>Capture d\'écran d\'un article de presse relatant l\'événement.</p>
</div>","Première plongée mer de l\'année pour la section Handicap, accueillie par le club d\'Etel.",NULL,"published",NOW(),NOW(),"2025-06-10 16:00:00","[]","Handisub","[\"handicap\", \"handisub\", \"inclusion\", \"Vieux Passage\"]",0,NULL,NULL),
(7,1,"Journée handisub Gabriel Deshayes CSV CSA","journee-handisub-gabriel-deshayes-csv-csa","<div class=\"prose max-w-none\">
<p>Le vendredi 20 juin, le Club Subaquatique des Vénètes a accueilli une journée Handisub avec l\'Association Gabriel Deshayes.</p>

<p>6 jeunes d\'une classe spécialisée pour troubles du langage ont été initiés à la plongée sous-marine.</p>

<p>Participants : 6 élèves et 2 enseignants, encadrés par les moniteurs du Club Subaquatique Auréen.</p>

<p>Formation initiale en piscine suivie de plongées en mer. Tous les participants ont reçu leurs diplômes de baptême de plongée.</p>

<p>Journée marquée par le soleil et la bonne humeur, tous sont repartis avec le sourire après leur aventure sous-marine.</p>

<p>Pique-nique partagé sur le \"Fleur de Corail\".</p>
</div>","6 jeunes de l\'Association Gabriel Deshayes initiés à la plongée dans le cadre d\'une journée handisub.",NULL,"published",NOW(),NOW(),"2025-06-20 17:00:00","[]","Handisub","[\"handisub\", \"Gabriel Deshayes\", \"inclusion\", \"baptême\"]",0,NULL,NULL),
(8,1,"Pot N1 pour l\'obtention de leur diplôme","pot-n1-pour-lobtention-de-leur-diplome","<div class=\"prose max-w-none\">
<p>Le 6 juin, les nouveaux diplômés \"Niveau 1\" du Club Subaquatique des Vénètes ont organisé un barbecue pour fêter leur réussite.</p>

<p>Ils ont invité les membres du club et les moniteurs qui les ont accompagnés tout au long de l\'année.</p>

<p>Soirée joyeuse avec Frédéric qui a animé le groupe en chantant, et les chansons ont continué tard dans la nuit.</p>

<p>Le club espère que le prochain groupe de plongeurs 2025/2026 maintiendra le même esprit positif.</p>

[carousel]
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/pot-n1-1.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/pot-n1-2.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/pot-n1-3.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/06/pot-n1-4.jpg
[/carousel]
</div>","Barbecue organisé par les nouveaux diplômés Niveau 1 pour célébrer leur réussite avec le club.",NULL,"published",NOW(),NOW(),"2025-06-06 19:00:00","[]","Formations","[\"niveau 1\", \"diplôme\", \"célébration\", \"barbecue\"]",0,NULL,NULL),
(9,1,"Fin de formation niveau 1","fin-de-formation-niveau-1","<div class=\"prose max-w-none\">
<p>Fin de formation Niveau 1 pour le Club Subaquatique des Vénètes.</p>

<p>La dernière journée de formation était le 17 mai, avec un soleil magnifique et des conditions de mer les plus idéales.</p>

<p>20 nouveaux plongeurs Niveau 1 ont terminé leur formation et n\'ont maintenant qu\'une envie : plonger et découvrir les sites.</p>

<p>Un grand merci aux moniteurs pour cette session et à nos plongeurs pour leur bonne humeur.</p>

[carousel]
https://www.plongee-venetes.fr/wp-content/uploads/2025/05/fin-formation-n1-1.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/05/fin-formation-n1-2.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/05/fin-formation-n1-3.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/05/fin-formation-n1-4.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/05/fin-formation-n1-5.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/05/fin-formation-n1-6.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/05/fin-formation-n1-7.jpg,
https://www.plongee-venetes.fr/wp-content/uploads/2025/05/fin-formation-n1-8.jpg
[/carousel]
</div>","20 nouveaux plongeurs Niveau 1 ont terminé leur formation dans des conditions idéales le 17 mai.",NULL,"published",NOW(),NOW(),"2025-05-17 16:00:00","[]","Formations","[\"niveau 1\", \"formation\", \"diplôme\", \"réussite\"]",0,NULL,NULL);