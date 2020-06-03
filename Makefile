VERSION = $(shell cat pom.xml | grep '<version>[0-9.]\+' | sed 's/<version>\([0-9.]\+\)<\/version>/\1/g' | tr -d '[:space:]')

$(DIST_TARGET): dist

clean:
		mvn clean

.PHONY: dist
dist:
		mvn validate package -Dmaven.test.skip=true

install:
		mvn install

release:
		mvn versions:set -DnewVersion=${NEW_VERSION}
		git commit -am "[release] ${NEW_VERSION}"
		git tag ${NEW_VERSION}
		echo "If everything is OK, you can push with tags i.e. git push origin master --tags"

unit:
		mvn test
