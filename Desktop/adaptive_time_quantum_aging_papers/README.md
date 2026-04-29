# Adaptive Time Quantum and Hardware Aging Study

This folder collects the research materials prepared for an idea at the intersection of:

- adaptive time quantum selection in CPU scheduling
- hardware aging / reliability-aware runtime control
- AI-assisted scheduler decisions

## Main Idea

The central research question is whether a scheduler can select `time quantum` values not only from
queue-state information, but also from thermal and aging-related hardware signals. The broader goal is
to study whether such a scheduler can achieve either:

- the same performance with less aging, or
- better performance under the same aging budget

## Folder Structure

- `docs/`
  Documentation, proposals, and supporting research notes.

- `papers/`
  Open-access papers grouped by topic.

- `meta/`
  Short project summary, future work list, and repository-facing helper texts.

## Key Outputs

Inside `docs/proposals/`, the most important final outputs are:

- `docs/proposals/aging_aware_adaptive_quantum_proposal_university_tr.pdf`
  Final Turkish university-style proposal.

- `docs/proposals/aging_aware_adaptive_quantum_proposal_university_en.pdf`
  Final English university-style proposal.

- `docs/proposals/proposal_university_tr.tex`
  Turkish LaTeX source.

- `docs/proposals/proposal_university_en.tex`
  English LaTeX source.

- `docs/notes/BIBLIOGRAPHY.md`
  Collected bibliography and link summary.

- `docs/notes/DETAILED_REPORT_TR.md`
  Detailed Turkish technical synthesis of the literature.

- `docs/notes/THESIS_PROJECT_PROPOSAL_TR.md`
  Early thesis/project proposal notes in Turkish.

- `docs/notes/EXPERIMENT_PLAN_AND_SIMULATOR_TR.md`
  Experiment design and simulator planning notes.

- `docs/notes/README_FINAL.md`
  Final notes directory summary.

Additional project-facing overview files:

- `meta/PROJECT_SUMMARY.md`
- `meta/FUTURE_WORK.md`
- `meta/GITHUB_ABOUT.md`

## Proposal Scope

The proposals describe a staged research plan:

1. Baseline fixed and dynamic Round Robin schedulers
2. Aging-aware heuristic scheduler
3. Physics-informed supervised learning for quantum prediction
4. Contextual bandit / reinforcement learning based policy exploration
5. Evaluation under both performance and reliability metrics

## Objective Evaluation Theme

The work is intentionally framed with both potential benefits and limitations. It does not assume the
proposed scheduler will always outperform classical methods; rather, it aims to reveal:

- when aging-aware adaptive scheduling helps
- when the overhead becomes too costly
- how the performance-reliability trade-off changes across workloads

## Repository-Friendly Layout

This folder is now organized closer to a standalone research repository layout, so that it can be
split into its own repository later if needed with minimal restructuring.

## Notes

- This repository folder was prepared as a research workspace rather than a polished software project.
- Some papers are included as direct PDFs, while others are referenced in the bibliography due to access limitations.
