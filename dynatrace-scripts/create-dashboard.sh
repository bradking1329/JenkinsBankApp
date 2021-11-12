#!/bin/bash

PAYLOAD=$(cat <<EOF
{
    "metadata": {
        "configurationVersions": [3],
        "clusterVersion": "1.206.47.20201102-132437"
    },
    "dashboardMetadata": {
        "name": "$1 $2:$3",
        "shared": false,
        "owner": "",
        "sharingDetails": {
            "linkShared": true,
            "published": false
        },
        "dashboardFilter": {
            "timeframe": ""
        }
    },
    "tiles": [{
        "name": "",
        "tileType": "HOSTS",
        "configured": true,
        "bounds": {
            "top": 38,
            "left": 228,
            "width": 228,
            "height": 152
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "HOST",
            "customName": "Hosts",
            "defaultName": "Hosts",
            "chartConfig": {
                "legendShown": true,
                "type": "TIMESERIES",
                "series": [],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "HOST": {
                    "AUTO_TAGS": ["JenkinsInstance:ANZ_ACM_Security_Group"]
                }
            }
        },
        "chartVisible": true
    }, {
        "name": "Jenkins-host",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 190,
            "left": 266,
            "width": 228,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "",
        "tileType": "SERVICES",
        "configured": true,
        "bounds": {
            "top": 304,
            "left": 0,
            "width": 190,
            "height": 190
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "SERVICE",
            "customName": "Services",
            "defaultName": "Services",
            "chartConfig": {
                "legendShown": true,
                "type": "TIMESERIES",
                "series": [],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "SERVICE": {
                    "AUTO_TAGS": ["$4:$5"]
                }
            }
        },
        "chartVisible": true
    }, {
        "name": "",
        "tileType": "DATABASES_OVERVIEW",
        "configured": true,
        "bounds": {
            "top": 646,
            "left": 0,
            "width": 228,
            "height": 152
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "DATABASE",
            "customName": "Databases",
            "defaultName": "Databases",
            "chartConfig": {
                "legendShown": true,
                "type": "TIMESERIES",
                "series": [],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "DATABASE": {
                    "NAME": ["test"]
                }
            }
        },
        "chartVisible": true
    }, {
        "name": "Service",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 266,
            "left": 0,
            "width": 190,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Problems",
        "tileType": "OPEN_PROBLEMS",
        "configured": true,
        "bounds": {
            "top": 38,
            "left": 0,
            "width": 152,
            "height": 152
        },
        "tileFilter": {}
    }, {
        "name": "Docker",
        "tileType": "DOCKER",
        "configured": true,
        "bounds": {
            "top": 38,
            "left": 532,
            "width": 304,
            "height": 152
        },
        "tileFilter": {}
    }, {
        "name": "Docker-details",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 190,
            "left": 570,
            "width": 228,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Database health",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 608,
            "left": 0,
            "width": 228,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Problems",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 190,
            "left": 0,
            "width": 152,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Application health",
        "tileType": "APPLICATIONS",
        "configured": true,
        "bounds": {
            "top": 874,
            "left": 0,
            "width": 152,
            "height": 152
        },
        "tileFilter": {},
        "chartVisible": true
    }, {
        "name": "My web application",
        "tileType": "APPLICATION",
        "configured": true,
        "bounds": {
            "top": 874,
            "left": 190,
            "width": 304,
            "height": 304
        },
        "tileFilter": {},
        "assignedEntities": ["APPLICATION-EA7C4B59F27D43EB"]
    }, {
        "name": "Response Time",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 266,
            "left": 228,
            "width": 228,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Failed Requests",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 266,
            "left": 494,
            "width": 228,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Request Count",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 266,
            "left": 722,
            "width": 304,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Custom chart",
        "tileType": "CUSTOM_CHARTING",
        "configured": true,
        "bounds": {
            "top": 304,
            "left": 494,
            "width": 228,
            "height": 190
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "MIXED",
            "customName": "Failure rate (server side  errors)",
            "defaultName": "Custom chart",
            "chartConfig": {
                "legendShown": true,
                "type": "SINGLE_VALUE",
                "series": [{
                    "metric": "builtin:service.keyRequest.errors.server.rate",
                    "aggregation": "AVG",
                    "type": "LINE",
                    "entityType": "SERVICE_KEY_REQUEST",
                    "dimensions": [{
                        "id": "0",
                        "name": "dt.entity.service_method",
                        "values": [],
                        "entityDimension": true
                    }],
                    "sortAscending": false,
                    "sortColumn": true,
                    "aggregationRate": "TOTAL"
                }],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "SERVICE_KEY_REQUEST": {
                    "AUTO_TAGS": ["$4:$5"]
                }
            }
        }
    }, {
        "name": "",
        "tileType": "CUSTOM_CHARTING",
        "configured": true,
        "bounds": {
            "top": 304,
            "left": 228,
            "width": 228,
            "height": 190
        },
        "tileFilter": {
            "timeframe": "-30m"
        },
        "filterConfig": {
            "type": "MIXED",
            "customName": "Server side response time",
            "defaultName": "Custom chart",
            "chartConfig": {
                "legendShown": true,
                "type": "SINGLE_VALUE",
                "series": [{
                    "metric": "builtin:service.keyRequest.response.server",
                    "aggregation": "AVG",
                    "type": "LINE",
                    "entityType": "SERVICE_KEY_REQUEST",
                    "dimensions": [{
                        "id": "0",
                        "name": "dt.entity.service_method",
                        "values": [],
                        "entityDimension": true
                    }],
                    "sortAscending": false,
                    "sortColumn": true,
                    "aggregationRate": "TOTAL"
                }],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "SERVICE_KEY_REQUEST": {
                    "AUTO_TAGS": ["$4:$5"]
                }
            }
        }
    }, {
        "name": "",
        "tileType": "CUSTOM_CHARTING",
        "configured": true,
        "bounds": {
            "top": 304,
            "left": 722,
            "width": 304,
            "height": 190
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "MIXED",
            "customName": "Request count",
            "defaultName": "Custom chart",
            "chartConfig": {
                "legendShown": true,
                "type": "TOP_LIST",
                "series": [{
                    "metric": "builtin:service.keyRequest.count.total",
                    "aggregation": "NONE",
                    "type": "LINE",
                    "entityType": "SERVICE_KEY_REQUEST",
                    "dimensions": [{
                        "id": "0",
                        "name": "dt.entity.service_method",
                        "values": [],
                        "entityDimension": true
                    }],
                    "sortAscending": false,
                    "sortColumn": true,
                    "aggregationRate": "TOTAL"
                }],
                "resultMetadata": {
                    "SERVICE_METHOD-6470404B2DBAEC09¦SERVICE_METHOD»SERVICE_METHOD-6470404B2DBAEC09»truebuiltin:service.keyRequest.count.total|NONE|TOTAL|LINE|SERVICE_KEY_REQUEST": {
                        "lastModified": 1602131534710,
                        "customColor": "#f5d30f"
                    }
                }
            },
            "filtersPerEntityType": {
                "SERVICE_KEY_REQUEST": {
                    "AUTO_TAGS": ["$4:$5"]
                }
            }
        }
    }, {
        "name": "Requests to Database",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 608,
            "left": 266,
            "width": 608,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Database connection",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 608,
            "left": 912,
            "width": 532,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Custom chart",
        "tileType": "CUSTOM_CHARTING",
        "configured": true,
        "bounds": {
            "top": 646,
            "left": 266,
            "width": 304,
            "height": 152
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "MIXED",
            "customName": "Number of calls to databases",
            "defaultName": "Custom chart",
            "chartConfig": {
                "legendShown": true,
                "type": "TOP_LIST",
                "series": [{
                    "metric": "builtin:service.keyRequest.dbChildCallCount",
                    "aggregation": "NONE",
                    "type": "LINE",
                    "entityType": "SERVICE_KEY_REQUEST",
                    "dimensions": [{
                        "id": "0",
                        "name": "dt.entity.service_method",
                        "values": [],
                        "entityDimension": true
                    }],
                    "sortAscending": false,
                    "sortColumn": true,
                    "aggregationRate": "TOTAL"
                }],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "SERVICE_KEY_REQUEST": {
                    "AUTO_TAGS": ["$4:$5"]
                }
            }
        }
    }, {
        "name": "Custom chart",
        "tileType": "CUSTOM_CHARTING",
        "configured": true,
        "bounds": {
            "top": 646,
            "left": 570,
            "width": 304,
            "height": 152
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "MIXED",
            "customName": "Time spent in database calls",
            "defaultName": "Custom chart",
            "chartConfig": {
                "legendShown": true,
                "type": "SINGLE_VALUE",
                "series": [{
                    "metric": "builtin:service.keyRequest.dbChildCallTime",
                    "aggregation": "NONE",
                    "type": "LINE",
                    "entityType": "SERVICE_KEY_REQUEST",
                    "dimensions": [{
                        "id": "0",
                        "name": "dt.entity.service_method",
                        "values": [],
                        "entityDimension": true
                    }],
                    "sortAscending": false,
                    "sortColumn": true,
                    "aggregationRate": "TOTAL"
                }],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "SERVICE_KEY_REQUEST": {
                    "AUTO_TAGS": ["$4:$5"]
                }
            }
        }
    }, {
        "name": "Custom chart",
        "tileType": "CUSTOM_CHARTING",
        "configured": true,
        "bounds": {
            "top": 646,
            "left": 1178,
            "width": 266,
            "height": 152
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "MIXED",
            "customName": "Connection failure rate",
            "defaultName": "Custom chart",
            "chartConfig": {
                "legendShown": true,
                "type": "SINGLE_VALUE",
                "series": [{
                    "metric": "builtin:service.dbconnections.failureRate",
                    "aggregation": "NONE",
                    "type": "LINE",
                    "entityType": "SERVICE",
                    "dimensions": [{
                        "id": "0",
                        "name": "dt.entity.service",
                        "values": [],
                        "entityDimension": true
                    }],
                    "sortAscending": false,
                    "sortColumn": true,
                    "aggregationRate": "TOTAL"
                }],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {}
        }
    }, {
        "name": "Custom chart",
        "tileType": "CUSTOM_CHARTING",
        "configured": true,
        "bounds": {
            "top": 646,
            "left": 912,
            "width": 266,
            "height": 152
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "MIXED",
            "customName": "Successful connections",
            "defaultName": "Custom chart",
            "chartConfig": {
                "legendShown": true,
                "type": "TOP_LIST",
                "series": [{
                    "metric": "builtin:service.dbconnections.success",
                    "aggregation": "NONE",
                    "type": "LINE",
                    "entityType": "SERVICE",
                    "dimensions": [{
                        "id": "0",
                        "name": "dt.entity.service",
                        "values": [],
                        "entityDimension": true
                    }],
                    "sortAscending": false,
                    "sortColumn": true,
                    "aggregationRate": "TOTAL"
                }],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "SERVICE": {
                    "SPECIFIC_ENTITIES": ["SERVICE-49AEE084C05915AB"]
                }
            }
        }
    }, {
        "name": "Infrastructure View",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 0,
            "left": 228,
            "width": 570,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Application-health",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 836,
            "left": 0,
            "width": 304,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "",
        "tileType": "SYNTHETIC_TESTS",
        "configured": true,
        "bounds": {
            "top": 874,
            "left": 570,
            "width": 304,
            "height": 304
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "WEB_CHECK",
            "customName": "",
            "defaultName": "Tagged synthetic monitor",
            "chartConfig": {
                "legendShown": true,
                "type": "TIMESERIES",
                "series": [],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "WEB_CHECK": {
                    "AUTO_TAGS": ["$1"]
                }
            }
        },
        "chartVisible": true
    }, {
        "name": "Synthetic-browser",
        "tileType": "HEADER",
        "configured": true,
        "bounds": {
            "top": 836,
            "left": 570,
            "width": 304,
            "height": 38
        },
        "tileFilter": {}
    }, {
        "name": "Custom chart",
        "tileType": "CUSTOM_CHARTING",
        "configured": true,
        "bounds": {
            "top": 874,
            "left": 874,
            "width": 304,
            "height": 304
        },
        "tileFilter": {},
        "filterConfig": {
            "type": "MIXED",
            "customName": "Successful executions",
            "defaultName": "Custom chart",
            "chartConfig": {
                "legendShown": true,
                "type": "TIMESERIES",
                "series": [{
                    "metric": "builtin:synthetic.browser.success",
                    "aggregation": "NONE",
                    "type": "LINE",
                    "entityType": "SYNTHETIC_BROWSER_MONITOR",
                    "dimensions": [{
                        "id": "0",
                        "name": "dt.entity.synthetic_test",
                        "values": [],
                        "entityDimension": true
                    }],
                    "sortAscending": false,
                    "sortColumn": true,
                    "aggregationRate": "TOTAL"
                }],
                "resultMetadata": {}
            },
            "filtersPerEntityType": {
                "SYNTHETIC_BROWSER_MONITOR": {
                    "AUTO_TAGS": ["$1"]
                }
            }
        }
    }]
}
EOF
)
echo $PAYLOAD
curl -k -H "Content-Type: application/json" -H "Authorization: Api-Token ${DT_TOKEN}" -X POST -d "${PAYLOAD}" ${DT_URL}/api/config/v1/dashboards
