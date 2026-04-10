<?php

namespace OpenXdmod\Migration;

use CCR\Helper\SymfonyCommandHelper;
use Xdmod\Template;

class DotEnvConfigMigration extends Migration
{

    public function execute()
    {
        $dotEnvPath = BASE_DIR . '/.env';
        if (!file_exists($dotEnvPath)) {
            $envTemplate = new Template('env');
            $envTemplate->apply([
                'app_secret' => hash('sha512', time())
            ]);
            file_put_contents(BASE_DIR . '/.env', $envTemplate->getContents());
            SymfonyCommandHelper::dumpDotEnv();
        }
    }
}
