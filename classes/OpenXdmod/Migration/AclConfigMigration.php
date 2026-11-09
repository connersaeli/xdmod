<?php

namespace OpenXdmod\Migration;

/**
 * A simple migration that just runs acl-config.
 *
 * @package OpenXdmod\Migration
 */
class AclConfigMigration extends Migration
{

    /**
     * @inheritdoc
     */
    public function execute()
    {
        $output = exec(BIN_DIR . '/acl-config 2>&1', $output, $result_code);

        if ($result_code !== 0) {
            $this->logger->error("Error executing acl-config", $output);
        }
    }
}
