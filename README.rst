This is an setup that depolys an puppetserver from puppetlabs using git, r10k
and hiera. It's developed on Ubuntu 16.04 and also tested on CentOS 7.2

What provides it? Let me say some cool stuff but otherwise.....

1.) a Puppet-Server
Puppet-Server using hiera and also with PuppetDB they is using PostgreSQL. The awsome r10k which
could handle branches and installs your modules from puppetforge or if choosen a
git repo. r10k handles the versions of modules they you could set inside the
Puppetfile. With branching you could test modules or different setups

2.) a MongoDB Cluster

I beginn with three nodes one master and two slaves. The configuration handles
puppet using hiera

3.) a Webserver based on apache and mod_wsgi
puppet will install on these node a sample webapp based on python they uses the
mongodb cluster as database backend. It installs a python virtenv, and inside the virtenv all
dependencies exclusive inside the virtenv. Apache serves the webapp with
mod_wsgi after all.


Prerequests

in a perfect world your vm's in the cloud wakes up provisioned with puppet. DHCP
has givem them an ip-address and the dns-names of your nodes are resolvable. and
so far puppet agent -t on the client node put's the box via autosign on the
server inside your environment.

Each file inside hieradata/nodes represents a node written as fqdn.yaml. Into
this demonstration im am using the domain webterrorist.net. So far you have to
chose your own domain. Otherwise you have to hack /etc/hosts, set the hostname
manually and afterwards you have to start the first puppetrun with your hands.

They repo ships sample configurations the I recommend to chooses. So you have to
rewrite on all files the dns-name to your working choise.


starting the project

checkout this git-repo on your designated puppet-master-server. Create an emty
git repository under /srv/puppet.git. Switch the repo url from github to these
repo. Please put the file sampleconfigs/scripts/post-receive to
/srv/puppet.git/hooks


Install the pupetlabs repo like

rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

yum install puppetserver puppet-agent


Please note they is no rpm-package for r10k for Redhat or CentOS. So you have
install it manuall.

/opt/puppetlabs/puppet/bin/gem install r10k

Or on Ubuntu like apt-get install r10k 

Prepare the configurationfiles with your right dns and put them like the
hierarchy under /etc/puppetlabs.
Please notice thate you should have something like 4 GB memory on these system.

push your changes like for dns into your new git repository. r10k should
checkout it and prepare all modules on the right way

start the puppets-server and run puppet agent -t on your puppetserver.
Everything should been installed and configured after all.

So if the puppet-server installed, fire up your nodes on your test clouds :)
After they have been registered inside your puppet environment they should
install everthing wahts needed for these project.



Post task

the blog is just a sample, they will been needed more love. So you could check
out the code and I would be happy about improvemnts.

write the first blog inside the sample webapp

login into your webserver

cd /var/www/webapp

python manage.py shell

now insert the first data

>>> from tumbleblog.models import *
>>> post = Post(
... title="Hello World!",
... slug="hello-world",
... body="Tumbleblog powered by MongoDB, MongoEngine, and Flask"
... )
>>> post.save()

please note you may have to correct the fqdn or the ip fo the mongodb master
under /var/www/webapp/tumbleblog/__init__.py

open a webbrower and open your fqdn.tld Otherwise the ip-address from your
webserver and your blog should running awsome

You could insert comments via webform.

that is all and thank you for reading!
