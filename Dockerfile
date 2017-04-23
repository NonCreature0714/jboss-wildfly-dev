# NOTE: This image is meant for development purposes only
# and not intended for production

# Pull from officical jboss/wildlfy
FROM jboss/wildfly

LABEL maintainer.name="Bill Brubaker" \
      maintainer.email="bill@pigonauts.com"

# Define user environment variables
ENV MGM_USER management-user
ENV MGM_USER_PASSWORD Password123!!!
ENV APP_USER app-user
ENV APP_USER_PASSWORD Password123!!!

# Define application root location
	# NOTE: Wildfly's default location for .war files is
	# located at /opt/jboss/wildfly/standalone/deployments.
	# Wildfly should automatically scan for any .war file
	# in any subdirectory of 'deployments/', however
	# in some cases, like when there are multiple .war
	# files in same-level directories, higher specificity
	# may be needed.
ENV APP_ROOT /opt/jboss/wildfly/standalone/deployments

# Create management and application users
# Then clear history so the passwords aren't leaked in history
RUN /opt/jboss/wildfly/bin/add-user.sh \
		"${MGM_USER}" "${MGM_USER_PASSWORD}" --silent \
	&& /opt/jboss/wildfly/bin/add-user.sh -a \
		"${APP_USER}" "${APP_USER_PASSWORD}" --silent \
	&& history -c

# Expose the app port and admin ports
#8080 is app
#9990 is admin
EXPOSE 8080
EXPOSE 9990

# Run the Wildfly application in managememt mode
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
