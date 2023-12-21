package policies.marketing.competitors

import data.policies.base.allowed_actions
import data.policies.base.ldap_competitors

realm:="/marketing/competitors/"

default permit = false

Response["Decision"] = "Permit" {
    permit
}

Response["Decision"] = "Deny" {
  not permit
}

Response["ObligationExpressions"] = oe {
  not permit
  oe :=
         {
            "ChallengeType": "REDIRECT",
            "ChallengeData": "http://localhost/login",
            "IdleTTL": "3600",
            "MaxTTL":"7200"
        }
}

Response["AdviceExpressions"] = ae {
  permit
  ae :=
         {
            "IdleTTL": "3600",
            "MaxTTL":"7200"
        }
}

permit {
  startswith(input.request.path,realm)
  no_of_methods := [x | x := allowed_actions[_]; x == input.request.method]
  count(no_of_methods) == 1
  no_of_users := [x | x := ldap_competitors[_]; x == input.request.access_subject]
  count(no_of_users) == 1
}
