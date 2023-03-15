import unittest
from unittest.mock import MagicMock, patch

import azure.functions as func
import json
import os
import eventgrid_handler
from parameterized import parameterized


current_directory = os.path.dirname(__file__)
data_directory = os.path.join(current_directory, "data")


@patch.dict(
    os.environ, {"WORKSPACE_ID": "workspace_id", "WORKSPACE_KEY": "workspace_key"}
)
class TestEventGridHandler(unittest.TestCase):
    @parameterized.expand(
        [
            ("valid_event", "eg_policy_insights_state_changed_comp.json", 1),
            ("valid_event", "eg_policy_insights_state_created_comp.json", 1),
            ("invalid_event", "eg_sbus_event.json", 0),
        ]
    )
    def test_eventgrid_handler(self, name, data_file, expected_result):
        # Given
        with open(os.path.join(data_directory, data_file)) as f:
            data = json.loads(f.read())

            test_data = func.EventGridEvent(**data[0])

            post_log_mock = MagicMock("Post LA mock")
            eventgrid_handler.post_la_data = post_log_mock

            # When
            eventgrid_handler.eventgrid_handler(test_data)

            # Then
            self.assertEqual(post_log_mock.call_count, expected_result)
