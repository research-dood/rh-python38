FROM registry.access.redhat.com/ubi8/python-38 

EXPOSE 8080
USER 0 

ENV PYTHON_VERSION=3.8 \
    PATH=$HOME/.local/bin/:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    CNB_STACK_ID=com.redhat.stacks.ubi8-python-38 \
    CNB_USER_ID=1001 \
    CNB_GROUP_ID=0 \
    PIP_NO_CACHE_DIR=off
    
# RHEL7 base images automatically set these envvars to run scl_enable. RHEl8
# images, however, don't as most images don't need SCLs any more. But we want
# to run it even on RHEL8, because we set the virtualenv environment as part of
# that script
ENV BASH_ENV=${APP_ROOT}/etc/scl_enable \
    ENV=${APP_ROOT}/etc/scl_enable \
    PROMPT_COMMAND=". ${APP_ROOT}/etc/scl_enable"
    

ENV SUMMARY="Platform for building and running Python $PYTHON_VERSION applications" \
    DESCRIPTION="Python $PYTHON_VERSION available as container is a base platform for \
building and running various Python $PYTHON_VERSION applications and frameworks. \
Python is an easy to learn, powerful programming language. It has efficient high-level \
data structures and a simple but effective approach to object-oriented programming. \
Python's elegant syntax and dynamic typing, together with its interpreted nature, \
make it an ideal language for scripting and rapid application development in many areas \
on most platforms."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Python 3.8" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,python,python38,python-38,rh-python38" \
      com.redhat.component="python-38-container" \
      name="ubi8/python-38" \
      version="1" \
      usage="s2i build https://github.com/sclorg/s2i-python-container.git --context-dir=3.8/test/setup-test-app/ ubi8/python-38 python-sample-app" \
      com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#UBI" \
      io.buildpacks.stack.id="com.redhat.stacks.ubi8-python-38" \
      maintainer="SoftwareCollections.org <sclorg@redhat.com>"
      
      
 RUN INSTALL_PKGS="python38 python38-devel python38-setuptools python38-pip nss_wrapper \
        httpd httpd-devel mod_ssl mod_auth_gssapi mod_ldap" &&\
    yum -y module enable python38:3.8 httpd:2.4 && \
    yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    # Remove redhat-logos-httpd (httpd dependency) to keep image size smaller.
    rpm -e --nodeps redhat-logos-httpd && \
    yum -y clean all --enablerepo='*'



