yumrepo { 'epel':
  descr => 'epel repo',
  mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch',
  enabled => 1,
  gpgcheck => 1,
  gpgkey => 'https://fedoraproject.org/static/0608B895.txt'
}