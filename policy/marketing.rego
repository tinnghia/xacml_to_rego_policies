package policies.marketing.main

import data.policies.marketing.general
import data.policies.marketing.competitors

policies:= {
    data.policies.marketing.general.realm       : "general",
    data.policies.marketing.competitors.realm   : "competitors"
}

sorted_policy_realms = array.reverse(sort(object.keys(policies)))
filtered_policy_list := [ x | x := sorted_policy_realms[_]; startswith( input.request.path, x )]

default permit = false

Response["Decision"] = "Permit" {
    permit
}

Response["Decision"] = "Deny" {
  not permit
}

Response["ObligationExpressions"] = oe {
  not permit
  count(filtered_policy_list) >0
  oe:=data.policies.testweb[policies[filtered_policy_list[0]]].oe
}

Response["AdviceExpressions"] = ae {
  permit
  count(filtered_policy_list) >0
  ae:=data.policies.testweb[policies[filtered_policy_list[0]]].ae
}

permit {
  count(filtered_policy_list) >0
  data.policies.testweb[policies[filtered_policy_list[0]]].permit
}
