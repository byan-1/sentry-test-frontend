# Must have `sentry-cli` installed globally
# Following variables must be passed in

SENTRY_AUTH_TOKEN=88170267c5b44c02a2815e07b017f3e4e1053461767c49259dbcd4cde0b01d78
SENTRY_ORG=hp-cl
SENTRY_PROJECT=web-frontend
REACT_APP_RELEASE_VERSION=v1#`sentry-cli releases propose-version`

setup_release: create_release upload_sourcemaps associate_commits

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(REACT_APP_RELEASE_VERSION)

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(REACT_APP_RELEASE_VERSION) \
		upload-sourcemaps --url-prefix "~/static/js" --validate build/static/js

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(REACT_APP_RELEASE_VERSION)
