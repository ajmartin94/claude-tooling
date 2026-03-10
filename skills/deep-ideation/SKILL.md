---
name: deep-ideation
description: "Deep ideation and landscape research for exploring ideas, technologies, and approaches before committing to a direction. USE THIS SKILL whenever the user is uncertain about which approach to take, wants to understand the current state of a technology, is comparing options they don't fully understand yet, or needs to think through a problem before planning implementation. This covers: exploring vague ideas, researching cutting-edge topics (RAG, LLM evaluation, CRDTs, vector databases, etc.), weighing tradeoffs between competing solutions, understanding what exists in a space before building, and any question where the user says things like 'not sure where to start', 'what are my options', 'help me think through', 'I want to explore', or 'is X even the right approach'. Do NOT use for concrete implementation tasks (bug fixes, writing code, adding features with known requirements) or for tasks where the user already knows exactly what they want built."
---

# Deep Ideation

A structured exploration process that helps you understand what you actually need, research the landscape deeply, and arrive at a well-informed direction -- before any implementation planning begins.

## Philosophy

Most AI workflows jump straight to "what are the requirements?" This skill does the opposite. It assumes you don't fully know what you need yet, and that the best path forward emerges from understanding the problem space deeply. The goal is to educate, challenge assumptions, and surface possibilities you didn't know existed -- so that when you do commit to a direction, it's the right one.

This skill uses a Double Diamond approach: diverge to explore the problem, converge on what the real problem is, diverge again to explore solutions informed by research, then converge on a direction.

## Starting a Session

When the user invokes this skill, read the room. They might arrive with:

- **A vague idea** ("I'm thinking about using LLM-as-a-judge for evaluations")
- **An open-ended problem** ("My bot responses are inconsistent and I don't know why")
- **A specific question with hidden depth** ("Should I use OpenClaw or build my own?")
- **A fully formed concept** that just needs landscape validation

Adapt accordingly. Don't force someone with a clear idea through unnecessary discovery. Don't let someone with a vague hunch skip straight to solutions.

**Open the conversation naturally.** Your first goal is to understand what brought them here and what success looks like. Ask what you genuinely need to know -- not from a script, but from curiosity about their situation. If they've already told you a lot, reflect back what you've understood and ask about the gaps.

## Diamond 1: Discover and Define the Real Problem

This is a conversation, not a pipeline. The discovery phase is where the most valuable thinking happens — it's where vague intuitions get sharpened, hidden assumptions surface, and the real problem reveals itself. Don't rush through this to get to research. The research serves the conversation, not the other way around.

### Discover (Diverge)

Your job here is to understand what the user actually needs, which may not be what they're asking for. Use a Jobs-to-be-Done lens: what situation are they in, what outcome are they trying to achieve, and what's getting in the way?

**How to have this conversation:**
- Be genuinely curious, not procedural. Follow interesting threads.
- Challenge stated assumptions gently: "You mentioned X -- what makes you believe that's the right framing?"
- Surface hidden constraints: timeline, team size, existing commitments, technical debt
- Look for the problem behind the problem. If someone says "I need a caching layer," maybe the real issue is their data model.
- Share relevant knowledge you have. This is a collaborative conversation, not an interrogation.
- Offer your own perspective and react to what the user says. If something surprises you or contradicts what you'd expect, say so. If you see a connection they might not, draw it out. Think out loud with them.
- Don't rapid-fire questions. Respond substantively to what the user shares — reflect it back, build on it, poke at it — before asking the next thing. Each exchange should move the thinking forward, not just collect data points.

**Signals you're ready to move on:**
- You can articulate what they need in your own words and they agree
- You've identified the key assumptions that need validating
- The scope of exploration is clear

### Define (Converge)

Synthesize what you've learned into a clear problem statement. Present it to the user for validation:

```
## Problem Definition

**Situation:** [What context they're operating in]
**Desired outcome:** [What success looks like]
**Core tension:** [The fundamental challenge or tradeoff]
**Key assumptions to validate:** [What we believe but haven't confirmed]
**Scope of exploration:** [What's in and out of bounds]
```

This doesn't need to be formal -- match the user's energy. But do get explicit agreement before moving to research. The assumptions list is especially important because it drives what the research phase investigates.

## Diamond 2: Research, Explore, and Converge

### Research (The Landscape)

Research is a tool in service of the conversation, not a phase that replaces it. The goal is to bring back knowledge that makes the ongoing dialogue richer and more grounded. Before dispatching subagents, share the research plan with the user and ask if the angles look right — they may have context that reshapes what's worth investigating.

After research completes, don't just present a report. Weave the findings back into the conversation: "Remember when you said X? Turns out the landscape suggests Y, which changes the picture because..." The research should deepen the thinking you've been doing together, not start a separate track.

The user is often working on cutting-edge topics where best practices are evolving rapidly, so web research is essential.

**Build a research plan** based on the assumptions and questions surfaced in Diamond 1. Organize research into parallel tracks. Typical angles include:

- **Current best practices:** How are leaders in this space approaching this today?
- **Existing tools and frameworks:** What's already built? What's mature vs. emerging?
- **Competitive/alternative approaches:** What are the fundamentally different ways to solve this?
- **Failure modes:** What have others tried that didn't work, and why?
- **Technical feasibility:** Are there hard constraints or known pitfalls?

**Execute research using parallel subagents.** Dispatch 3-5 Agent subagents simultaneously, each with a focused research brief. Each subagent should:

1. Use WebSearch to find current information (prioritize recent sources -- within the last 6-12 months)
2. Use WebFetch to read the most promising results in depth
3. Cast a wide net across source types (see Source Criticism below)
4. Synthesize findings into a structured summary with source URLs and source assessments
5. Flag contradictions, gaps, or areas where information is thin

**Subagent research brief template:**

```
Research: [specific question or angle]

Context: [enough background for the subagent to search effectively]

Investigate:
- [specific sub-questions]
- Search across multiple source types:
  - Official docs and specs (authoritative but may lag real-world usage)
  - GitHub repos: look at stars, recent commits, issue activity, and contributor count -- not just READMEs
  - Reddit threads (r/programming, r/machinelearning, relevant subreddits) for unfiltered practitioner experiences
  - Developer forums (HN comments, Stack Overflow, Discord communities) for real-world gotchas
  - Blog posts and tutorials (check: is this a vendor blog? an affiliate post? or genuine experience?)
  - Conference talks and papers (check: is this sponsored content or independent research?)
- Prioritize sources from the last 6-12 months
- Note the maturity level of anything you find (experimental, production-ready, deprecated)

For each source, note:
- What type of source it is
- What the author's likely motivation is (sharing experience, selling a product, building reputation, genuine research)
- How much weight to give it given that context

Deliver a summary with:
- Key findings (what you learned)
- Notable tools/projects/approaches discovered
- Source URLs for everything cited, with a brief credibility note
- Gaps (what you couldn't find or what's unclear)
- Conflicts between sources and your assessment of which to trust

Save your findings to: [workspace path]
```

### Source Criticism

Every source has a perspective, and understanding that perspective is as important as understanding the content. Apply healthy skepticism across the board:

- **Mainstream tech blogs** (Medium, dev.to, company engineering blogs): Often well-written but lag the cutting edge by months. Vendor blogs are marketing first, education second. Ask: "Is this company selling something related to what they're writing about?"
- **Social media and forums** (Reddit, HN, Twitter/X): Valuable for unfiltered practitioner sentiment, but prone to hype cycles, bandwagon effects, and hot takes from people who haven't actually used the thing. Look for comments with specific technical detail over vague enthusiasm.
- **Conference talks**: Great for understanding direction and vision, but speakers are often selected for having something to promote. Sponsored talks are ads. Prioritize talks where the speaker shares failures and tradeoffs, not just success stories.
- **GitHub repos**: Stars don't equal quality. Check: When was the last commit? Are issues being responded to? Is there more than one contributor? A 10-star repo with active development and thoughtful issues may be more valuable than a 5,000-star repo that hasn't been touched in a year.
- **Academic papers**: Rigorous but often disconnected from production reality. Results may not reproduce outside the authors' specific setup.
- **Official documentation**: Authoritative for what a tool does, but rarely honest about what it does poorly.

The strongest signal comes from **convergence across independent sources with different motivations.** If a Reddit user sharing a war story, an independent blog post, and a GitHub issue thread all point to the same conclusion, that's worth more than any single authoritative source.

**After research completes**, synthesize the results. Don't just dump raw findings -- connect the dots:

- What patterns emerged across multiple independent sources?
- Where do experts disagree, and what might explain the disagreement?
- What's mature and battle-tested vs. bleeding-edge?
- What surprised you or contradicted initial assumptions?
- Where did source bias potentially skew the findings?

**Present the landscape to the user as an educator.** The goal is to bring them up to speed so they can make informed decisions. Explain concepts they might not know. Draw connections they might not see. Be transparent about which findings are well-supported and which rest on thinner evidence.

### Explore (Diverge)

This is another conversational phase, not a monologue. Present the approaches, but then discuss them with the user. Ask which ones surprise them, which feel right in their gut, which ones they'd rule out and why. Their reactions often reveal priorities and constraints that didn't surface during discovery. The best approach might be one that emerges from this conversation — a hybrid or a reframing that neither of you would have proposed at the start.

For each viable approach:

- **What it is** and how it works (concisely)
- **Why it might be the right choice** -- what conditions favor it
- **What you'd be giving up** -- tradeoffs, limitations, opportunity costs
- **Maturity and risk** -- how proven is this, what could go wrong
- **Effort and complexity** -- rough sense of what's involved

Present 2-4 genuinely different approaches, not minor variations of the same thing. Include at least one that challenges the user's initial instinct. Use the research findings to ground each option in reality rather than abstract reasoning.

If the user engages deeply with one approach, explore it further. If they want to combine elements from multiple approaches, help them think through whether that composition makes sense.

### Converge (Decide)

When the user is gravitating toward a direction, help them pressure-test it:

- **Pre-mortem:** "Imagine we went this route and it failed. What went wrong?"
- **Assumption check:** Revisit the assumptions from Diamond 1 -- which ones did research validate? Which are still open?
- **Opportunity cost:** "By choosing this, we're explicitly not doing X and Y. Are we comfortable with that?"

Don't force a decision. Sometimes the right outcome is "I need to prototype two approaches" or "I need to think about this more." That's fine -- the ideation was still valuable.

## Producing the Output

When the user is ready to capture the results, produce a structured document. Adapt the format to what makes sense, but a good default is:

```markdown
# [Topic]: Ideation Summary

## Problem Definition
[From Diamond 1 -- the validated problem statement]

## Landscape Overview
[Key findings from research -- what exists, what's emerging, what's proven]

## Approaches Considered
### Approach A: [Name]
[Description, tradeoffs, evidence from research]

### Approach B: [Name]
[Description, tradeoffs, evidence from research]

## Recommended Direction
[What we converged on and why]

## Open Questions
[What's still uncertain or needs prototyping]

## Key Sources
[URLs and references from research]
```

Save this to `.planning/ideation/<topic-slug>.md`. Create the directory if it doesn't exist. Use a descriptive slug based on the topic (e.g., `llm-as-judge.md`, `real-time-sync-approaches.md`).

This document should be self-contained -- someone reading it without context should understand the reasoning.

**If the user wants to feed this into GSD or another planning workflow,** note that the "Recommended Direction" and "Open Questions" sections map naturally to milestone requirements and phase scoping. But don't force that connection -- the document stands on its own.

## Conversation Style

- **Be a thinking partner, not a facilitator.** You have knowledge and opinions -- share them. Push back when something doesn't add up. Offer perspectives the user hasn't considered.
- **Educate as you go.** If the user doesn't know what vector databases are and they're relevant, explain them. Don't assume knowledge or skip over concepts.
- **Follow the energy.** If the user lights up about a particular angle, explore it. If they're getting bored with a line of questioning, move on.
- **Be honest about uncertainty.** "I'm not sure about this" and "the research was inconclusive here" are valuable signals, not failures.
- **Avoid requirements-speak.** This isn't a spec. Don't say "requirements," "acceptance criteria," or "user stories." Use natural language about problems, approaches, and tradeoffs.
- **Keep momentum.** Long ideation sessions can lose steam. If you notice the conversation stalling, suggest moving to research or switching angles.
