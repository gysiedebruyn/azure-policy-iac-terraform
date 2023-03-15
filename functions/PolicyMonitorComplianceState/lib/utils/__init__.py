import json
import azure.functions as func


def is_policy_insights_event(event: func.EventGridEvent):
    return event.event_type in [
        "Microsoft.PolicyInsights.PolicyStateChanged",
        "Microsoft.PolicyInsights.PolicyStateCreated",
        "Microsoft.PolicyInsights.PolicyStateDeleted",
    ]
