<?php

namespace App\Twig;

use Twig\Extension\AbstractExtension;
use Twig\TwigFunction;

class GoogleMapsExtension extends AbstractExtension
{
    public function __construct(
        private string $googleMapsApiKey
    ) {}

    public function getFunctions(): array
    {
        return [
            new TwigFunction('google_maps_api_key', [$this, 'getGoogleMapsApiKey']),
        ];
    }

    public function getGoogleMapsApiKey(): string
    {
        return $this->googleMapsApiKey;
    }
}
