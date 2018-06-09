# For manually building and deploying to dockerhub after a release
# Must log into dockerhub before running

if [[ $# -eq 0 ]] ; then
    echo 'Usage: ./docker-production/local-deploy.sh tag'
    exit 0
fi

RELEASE=$1

mvn openmrs-sdk:build-distro -B -Ddir=refapp-production -DskipTests
rm refapp-production/web/modules/referencedemodata-*
cp docker-production/startup.sh refapp-production/web/startup.sh

docker build refapp-production/web/ --tag isears/refapp-production:$RELEASE
docker push isears/refapp-production:$RELEASE