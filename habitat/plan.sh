pkg_name=simple-jar
pkg_origin=danuf
pkg_version="0.0.1"
pkg_deps=(core/maven)

do_build() {

  # By default, we're in the directory in which the Studio was entered
  # (in this case, presumably the project root), so we can run commands
  # as though we were in that same directory. By the time we reach this
  # callback, `npm` will have been installed for us.
  mvn clean install -DskipTests=true
}
