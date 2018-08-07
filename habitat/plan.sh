pkg_name=simple-jar
pkg_origin=danuf
pkg_version="0.0.1"
pkg_deps=(core/jre8 core/maven)

do_build() {
  mvn clean install -DskipTests=true
}

do_install()
{
    cp ${HAB_CACHE_SRC_PATH}/${pkg_dirname}/target/${pkg_name}.jar ${PREFIX}/
}
