# Wildfly Development Image

This image is intended for development environments and is not production ready.

It does not separate Management mode from Application Server in separate images. Rather, it runs the server in management and server mode together so both can be easily accessed by a user at the same time. The means anything in the management page directly affects the application server because they are one and the same.

## Run the container in default mode

**To run the container and test it's working:**

To test a Wildfly container can run on your localhost, run:

```bash
   $ docker run -it -p 8080:8080 -p 9990:9990 \
   noncreature0714/wildfly-dev-server
```

You can then navigate to http://localhost:8080 for a welcome page.

Or go to http://localhost:9990 for the management console where you will be prompted to enter a username and password.

*Default management user: `management-user`

*Default management user password: `Password123!!!`

*Default application user: `app-user`

*Default application user password: `Password123!!!`

**Quickly test a single `.war` file by
placing a `.war` file into `~/wildfly-app` directory on your localhost.**

> **NOTE:** If you happen to run this command without creating a `~/wildfly-app` directory first, fear not, because docker will create one for you. Again, simply place the `.war` file there and Wildfly's deployment-scanner will pick it up.

```bash
   $ docker run -it -p 8080:8080 -p 9990:9990 \
   -v ~/wildfly-app/:/opt/jboss/wildfly/standalone/deployments/ \
   noncreature0714/wildfly-dev-server
```

Only use this image to verify you can download and run the server! You'll need to change your user name and password later.

## Run the Container with Custom Users and Mount Local File System Using Wildfly's `deployment-scanner`
There are four environment variables which can be re-assigned in order to setup management and application user accounts.

**MGM_USER**

**MGM_USER_PASSWORD**

**APP_USER**

**APP_USER_PASSWORD**

You'll need to change them in order to setup your own accounts.

```bash
   $ docker run \
   -e 'MGM_USER=your-manager-user-here' \
   -e 'MGM_USER_PASSWORD=your-manager-user-password' \
   -e 'APP_USER=your-app-user-here' \
   -e 'APP_USER_PASSWORD=your-app-user-password' \
   -it \
   -p 8080:8080 \
   -p 9990:9990 \
   -v ~/wildfly-app/:/opt/jboss/wildfly/standalone/deployments/ \
   noncreature0714/wildfly-dev-server
```
