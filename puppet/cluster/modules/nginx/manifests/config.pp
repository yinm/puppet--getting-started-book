class nginx::config {
  file { '/etc/nginx/conf.d/my.conf':
    content => template('nginx/my.conf'),
  }

  file { '/usr/share/ninx/html/index.html':
    content => template('nginx/index.html'),
  }
}