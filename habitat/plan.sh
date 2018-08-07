pkg_name=simple-jar
pkg_origin=danuf
pkg_version="0.0.1"
pkg_deps=(core/maven)

do_build() {
  mvn clean install -DskipTests=true
}
