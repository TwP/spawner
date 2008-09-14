# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'spawner'

task :default => 'manifest'

PROJ.name = 'spawner'
PROJ.authors = 'Tim Pease'
PROJ.email = 'tim.pease@gmail.com'
PROJ.url = 'http://codeforpeople.rubyforge.org/spawner'
PROJ.version = Spawner::VERSION
PROJ.rubyforge.name = 'codeforpeople'
PROJ.readme_file = 'README.rdoc'

PROJ.rdoc.main = 'README.rdoc'
PROJ.rdoc.include << 'README.rdoc'
PROJ.rdoc.remote_dir = 'spawner'

PROJ.ann.email[:server] = 'smtp.gmail.com'
PROJ.ann.email[:port] = 587

task 'gem:package' => 'manifest:assert'

# EOF
