# xacml_to_rego_policies
[XACML](https://docs.oasis-open.org/xacml/3.0/xacml-3.0-core-spec-os-en.html) to [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) policies collection

A sample conversion demonstrating how to translate an XACML-based policy, defined in XML, into a Rego-policy, expressed as code

## Scenario
*  Employees in marketing department are authorized to access all /marketing/ resources.
*  Only employees belonging to the marketing competitors group are authorized to access all resources under the /marketing/competitors/ path.
*  Only HTTP requests with GET or POST methods are allowed.

### The XACML policy set consists of two policies:
* General policy for the Marketing department
* Competitors group policy within the Marketing department

The algorithm used in both is Deny Unless Permit

The equivalent Rego policies are organized in a subdirectory named **[policy](policy)**
* [base.rego](policy/base.rego) : mocking data 
* [general_marketing_policy.rego](policy/general_marketing_policy.rego): marketing department general policy
* [marketing_competitors_policy.rego](policy/marketing_competitors_policy.rego): marketing competitors group policy
* [marketing.rego](policy/marketing.rego): main policy for marketing department

While Axiomatics offers [ALFA](https://axiomatics.com/blog/ten-years-of-alfa) as a policy-as-code language for XACML, Rego stands out as a more flexible and user-friendly alternative.

Rego's more flexible approach, not bound to predefined algorithms, enables easier implementation of logic like realm determination used in [Broadcom Siteminder's Realms Processing](https://techdocs.broadcom.com/us/en/symantec-security-software/identity-security/siteminder/12-8/configuring/policy-server-configuration/realms.html).

Read more about it on my blog