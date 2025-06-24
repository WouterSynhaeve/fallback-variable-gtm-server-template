___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Fallback Variable",
  "description": "Returns the first variable that has a value from a prioritized list. If none have a value, returns the configured default (which can be undefined or custom).",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SIMPLE_TABLE",
    "name": "variables",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Prioritized Variables",
        "name": "variable",
        "type": "TEXT"
      }
    ],
    "newRowButtonText": "Add variable",
    "help": "Variables are evaluated in order. The first one with an acceptable value is returned. Falsy values (e.g., false, null, 0, undefined) are skipped unless explicitly allowed."
  },
  {
    "type": "CHECKBOX",
    "name": "defaultSet",
    "checkboxText": "Provide default value",
    "simpleValueType": true,
    "subParams": [
      {
        "type": "TEXT",
        "name": "defaultValue",
        "displayName": "Default Value",
        "simpleValueType": true,
        "help": "If all prioritized variables fail, this default value will be returned.\nUncheck the option if you want the default to be undefined.\nYou can use an empty string as the default by leaving the input blank while keeping the default enabled.",
        "canBeEmptyString": true,
        "enablingConditions": [
          {
            "paramName": "defaultSet",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "acceptableValuesGroup",
    "displayName": "Acceptable falsy values",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "acceptFalseValues",
        "checkboxText": "false",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "accept0Values",
        "checkboxText": "0",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "acceptNullValues",
        "checkboxText": "null",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "acceptNaNValues",
        "checkboxText": "NaN",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "acceptEmptyStringValues",
        "checkboxText": "\"\" (empty string)",
        "simpleValueType": true
      }
    ],
    "help": "By default, falsy values are skipped. If your use case requires accepting certain falsy values (e.g., 0, false, \"\"), check them here to include them as valid outputs."
  }
]


___SANDBOXED_JS_FOR_SERVER___

//const logToConsole = require('logToConsole');
const getType = require('getType');

for (let i = 0; i < data.variables.length; i++) {
  const value = data.variables[i].value;
//  logToConsole("type: "+getType(value));
  if (
      (data.acceptFalseValues && value === false) ||
      (data.accept0Values && value === 0) ||
      (data.acceptNullValues && value === null) ||
      (data.acceptEmptyStringValues && value === '') ||
      value) {
    return value;
  }
}

return data.defaultSet ? data.defaultValue : undefined;


___TESTS___

scenarios: []


___NOTES___

Created on 24/6/2025, 20:04:14


