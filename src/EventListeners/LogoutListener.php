<?php

declare(strict_types=1);

namespace CCR\EventListeners;

use SimpleSAML\Auth\Simple;
use SimpleSAML\Auth\Source;
use SimpleSAML\Session;
use Symfony\Component\EventDispatcher\Attribute\AsEventListener;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Http\Event\LogoutEvent;

#[AsEventListener(event: LogoutEvent::class)]
class LogoutListener
{
    public function __construct(
        private UrlGeneratorInterface $urlGenerator,
    ) {
    }

    public function __invoke(LogoutEvent $event): void
    {
        $homePage = $this->urlGenerator->generate('xdmod_home');

        $sources = Source::getSources();
        $auth = new Simple($sources[0]);
        if ($auth->isAuthenticated()) {
            $logoutURL = $auth->getLogoutURL($homePage);
        } else {
            $logoutURL = $homePage;
        }
        Session::getSessionFromRequest()->cleanup();

        $logoutResponse = new JsonResponse(
            data: ['returnTo' => $logoutURL],
            status: Response::HTTP_OK
        );

        $event->setResponse($logoutResponse);
    }
}
