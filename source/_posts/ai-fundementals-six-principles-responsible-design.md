---
title: Microsoft's Responsible AI Principles for Building Ethical AI Systems
date: 2023-05-10 21:39:48
tags:
- AI
- Azure
- Microsoft
- Design
---

## Introduction

The responsible development and deployment of AI systems is crucial to ensure fairness, reliability, security, privacy, inclusiveness, understandability, and accountability. In this article, we will summarize key principles for building ethical AI systems.

For a more comprehensive understanding of responsible AI, refer to the full overview [here](https://learn.microsoft.com/en-za/training/modules/get-started-ai-fundamentals/8-understand-responsible-ai).

## Fairness

- AI systems should treat all people fairly.
- Bias should be avoided, such as gender or ethnicity-based bias.
- Unfair advantages or disadvantages to specific groups should be prevented.

**Azure Machine Learning and fairness:**

- Azure Machine Learning has the capability to interpret models and quantify the influence of each data feature on predictions.
- This helps identify and mitigate bias in models.

> Another example is Microsoft's implementation of Responsible AI with the Face service, which retires facial recognition capabilities that can be used to try to infer emotional states and identity attributes. These capabilities, if misused, can subject people to stereotyping, discrimination or unfair denial of services.

## Reliability and safety

- AI systems should perform reliably and safely.
- Examples include AI-based software for autonomous vehicles and machine learning models for medical diagnosis.
- Unreliable systems pose significant risks to human life.

**Testing and deployment management for AI-based software:**

- Rigorous testing and deployment management processes are necessary for AI-based software development.
- These processes ensure that the systems function as expected before release.

## Privacy and security

- AI systems should prioritize security and respect privacy.
- Machine learning models rely on large volumes of data, including personal details that must be kept private.
- Privacy and security considerations should continue even after the models are trained and the system is in production.
- Both the data used for predictions and the decisions made from that data may be subject to privacy or security concerns.

## Inclusiveness

- AI systems should empower and engage everyone.
- AI should bring benefits to all parts of society.
- Factors such as physical ability, gender, sexual orientation, ethnicity, and others should not hinder access to AI benefits.

## Transparency

- AI systems should be designed to be easily understood by users.
- Users should be fully informed about the purpose of the system.
- Users should have knowledge of how the system works.
- Users should be aware of the limitations of the system.

## Accountability

- People involved in designing and developing AI systems should be accountable.
- Governance and organizational principles should guide the creation of AI-based - solutions.
- Ethical and legal standards should be clearly defined and upheld.
- Designers and developers should work within this framework to ensure compliance.

# Resources


https://www.microsoft.com/en-us/ai/responsible-ai-resources?rtc=1  
https://blogs.microsoft.com/on-the-issues/2022/06/21/microsofts-framework-for-building-ai-systems-responsibly/  
https://learn.microsoft.com/en-za/training/paths/get-started-with-artificial-intelligence-on-azure/  