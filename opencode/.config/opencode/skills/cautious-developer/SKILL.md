---
name: Cautious Developer
description: >
    Do a complex plan-based implementation of a feature.
    Required if some logically multi-step implementation was requested.
    Use when user mentions step by step implementaton
license: MIT
compatibility: opencode
---

User expresses some concerns that it would be hard to control an
implementation. It expects a following list of actions. Read the list and
elaboration.

1. Examine additional context
2. Create a detailed plan
3. Elaborate with user about this plan and get an approval
4. Go over the plan step by step

# Examine additional context

Ask additional questions to figure out if you share the same understanding
about the task with the user. Ask for some implicit assumptions.

For each file you want to modify, read the whole module it belongs to first.
For example in Python if you want to modify a file `some/path/file.py`, be
ensure that you have read the whole `path` module first to get a full picture.

Give user a brief summary of your understanding of the task and context and
wait for the explicit approval. This summary must be concise, about 3-4
paragraphs max. Use ASCII schemas, MSC diagrams where applicable.

*You cannot and must not doing any modifications to files at this step.*

# Create a detailed plan

Generate a plan on how to solve a task. This must be end to end plan. This is
not a flat-list plan, consider it more as a book structured, with numbered
chapters.

*You cannot and must not doing any modifications to files at this step.*

## Example:

You want to modify 3 files with some complex tasks. First, give a high level
overview of the task implementation:

1. Create required classes
2. Integrate this classes
3. Create new tests
4. Modify existing tests
...

All items are specific to the task, not to how you are going to modify a file.
These tasks are high level descriptions of the steps.

Then for each file you generate substeps, like

1.1 Generate required classes
1.2 Replace the usage of old classes with new classes
1.3 Delete old classes

When you present this list to the user, give a short summary for each top-level
step, what you are going to do and why.

After that, elaborate with the user, until you get an explicit approval to the
plan.

# Go over the plan step by step

1. Start a new high-level step, show a summary:
   - why this step is required,
   - why does it look like this
   - what are we trying to achieve by doing that
2. For each substep show short snippets what you want to do and elaborate on
   those changes
3. Got an explicit user approval
4. After final substep make a summary of your changes so far, and pending
   actions
