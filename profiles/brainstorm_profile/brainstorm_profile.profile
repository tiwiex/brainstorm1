<?php
/**
 * @file
 * Enables modules and site configuration for a standard site installation.
 */


/**
 * Implements brainstorm_profile_install_tasks_alter().
 */
function brainstorm_profile_install_tasks_alter(&$tasks, $install_state) {
  foreach ($install_state as $state) {
    if ($state === 'install_bootstrap_full') {
      $source = 'profiles/brainstorm_profile/libraries/';
      $res = 'libraries/';
      brainstorm_profile_recurse_copy($source, $res);
      drupal_get_messages();
    };
  }
}

/**
 * Recursive copy.
 *
 * @param string $src
 *   - Source folder with files.
 * @param string $dst
 *   - Destination folder.
 */
function brainstorm_profile_recurse_copy($src, $dst) {
  $dir = opendir($src);
  @mkdir($dst);
  while (FALSE !== ($file = readdir($dir))) {
    if (($file != '.') && ($file != '..')) {
      if (is_dir($src . '/' . $file)) {
        brainstorm_profile_recurse_copy($src . '/' . $file, $dst . '/' . $file);
      }
      else {
        copy($src . '/' . $file, $dst . '/' . $file);
      }
    }
  }
  closedir($dir);
}

/**
 * brainstorm_profile clean alias.
 *
 * @param string $text
 *   String that be changing.
 *
 * @return string
 *   Return machine name for text.
 */
function _brainstorm_profile_clean_alias($text) {
  return preg_replace('/\-+/', '-', strtolower(preg_replace('/[^a-zA-Z0-9_-]+/', '', str_replace(' ', '-', $text))));
}

