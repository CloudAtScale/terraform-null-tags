module.exports = {
    "tagFormat": "${version}",
    "branches": ["main"],
    "plugins": [
        "@semantic-release/changelog",
        "@semantic-release/github",
        [
            "@semantic-release/commit-analyzer",
            {
                "preset": "conventionalcommits",
                "releaseRules": [
                    {
                        "release": "patch",
                        "scope": "deps",
                        "type": "chore"
                    }
                ]
            }
        ],
        [
            "@semantic-release/release-notes-generator",
            {
                "preset": "conventionalcommits",
                "presetConfig": {
                    "types": [
                        {
                            "section": ":rocket: Features",
                            "type": "feat"
                        },
                        {
                            "hidden": false,
                            "section": ":bug: Bug Fixes",
                            "type": "fix"
                        },
                        {
                            "hidden": false,
                            "section": ":chart_with_upwards_trend: Performance Improvements",
                            "type": "perf"
                        },
                        {
                            "hidden": false,
                            "section": ":back: Reverts",
                            "type": "revert"
                        },
                        {
                            "hidden": false,
                            "section": ":books: Documentation",
                            "type": "docs"
                        },
                        {
                            "hidden": false,
                            "section": ":ring: Styles",
                            "type": "style"
                        },
                        {
                            "hidden": false,
                            "section": ":package: Miscellaneous Chores",
                            "type": "chore"
                        },
                        {
                            "hidden": false,
                            "section": ":hammer_pick: Code Refactoring",
                            "type": "refactor"
                        },
                        {
                            "hidden": false,
                            "section": ":fingers_crossed: Tests",
                            "type": "test"
                        },
                        {
                            "hidden": false,
                            "section": ":man_construction_worker: Build System",
                            "type": "build"
                        },
                        {
                            "hidden": false,
                            "section": ":robot: Continuous Integration",
                            "type": "ci"
                        }
                    ]
                }
            }
        ],
        [
            "@semantic-release/git",
            {
                "assets": [
                    "CHANGELOG.md",
                    "version.yaml"
                ]
            }
        ],
        [
            "@semantic-release/exec",
            {
                "prepareCmd": "yq e \".ModuleVersion = ${nextRelease.version}\" -i. version.yaml"
            }
        ]
    ]
}
