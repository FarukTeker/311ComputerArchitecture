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

- `time_quantum/`
  Open-access papers collected on adaptive or dynamic time quantum scheduling.

- `hardware_aging/`
  Open-access papers collected on hardware aging, reliability-aware control, thermal management, and related methods.

- `notes/`
  Generated notes, proposal drafts, detailed reports, experiment planning, and final proposal documents.

## Key Outputs

Inside `notes/`, the most important final outputs are:

- `aging_aware_adaptive_quantum_proposal_university_tr.pdf`
  Final Turkish university-style proposal.

- `aging_aware_adaptive_quantum_proposal_university_en.pdf`
  Final English university-style proposal.

- `proposal_university_tr.tex`
  Turkish LaTeX source.

- `proposal_university_en.tex`
  English LaTeX source.

- `BIBLIOGRAPHY.md`
  Collected bibliography and link summary.

- `DETAILED_REPORT_TR.md`
  Detailed Turkish technical synthesis of the literature.

- `THESIS_PROJECT_PROPOSAL_TR.md`
  Early thesis/project proposal notes in Turkish.

- `EXPERIMENT_PLAN_AND_SIMULATOR_TR.md`
  Experiment design and simulator planning notes.

- `README_FINAL.md`
  Final notes directory summary.

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

## Notes

- This repository folder was prepared as a research workspace rather than a polished software project.
- Some papers are included as direct PDFs, while others are referenced in the bibliography due to access limitations.
