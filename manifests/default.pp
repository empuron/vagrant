$meine_pakete = ['httpd', 'vim', 'python', 'pip']
  package { $meine_pakete:
    ensure => 'installed'
  }
