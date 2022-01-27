#!groovy

import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(admin, admin)
instance.setSecurityRealm(hudsonRealm)


def strategy = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, admin)
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)


instance.save()
