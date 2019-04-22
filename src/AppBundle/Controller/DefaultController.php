<?php

namespace AppBundle\Controller;

use Pimcore\Controller\FrontendController;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class DefaultController extends FrontendController
{
    /**
     * @param Request $request
     * @return Response|null
     * @Route("/", name="index")
     */
    public function index(Request $request): ?Response
    {
        return new Response("Hello");
    }
}
