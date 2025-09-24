# Code Review

I want you to think about and plan out a systematic review of this codebase. YOU MUST NOT FIX ANYTHING. Your sole mission is the understand, analyze, and come up with recommendations. You must document your learnings extremely carefully and regularly. This code base was largely written by AI. The app works. But there are many small issues with the code, sometimes functional issues, but often just maintainability issues or code smell issues. Your goal is to find them and other opportunities to really bring this code base to a high level of quality and maintainability, though in general you should not be proposing large scale rethinking of how parts of it work unless you think some existing aspect is very bad and NEEDS that change.

Here's how I think you should go about this.

First understand the repo structure. Systematically catalog all files and what they are for in review-file-list.md. Use task lists in that file ([ ] lists) since in later steps you'll be checking things off. Don't guess at what each file is, take a quick look, but don't worry about systematically reviewing all lines of every file--that's the next step. use subagents in parallel when you think appropriate (e.g. to review all the files in a folder, etc

Second, understand the contents of each file in detail. What does the file do? what methods are in it? When you're done, you should have read every line of every file. This will obviously also require judicious use of subagents (in parallel when possible) due to context window limits. Document these findings in detail in review-code-details.md. Read and update review-file-list.md to make sure you don't miss any files that you found in the first step. As you read each file, if you find things you think are noteworthy or deserve further study, include them in review-code-details.md.

Third, now assemble a list of general concerns in review-concerns.md (again with task [ ] lists you can check off later). Go through review-code-details.md and spin off investigations. Your goal is to end this step with a comprehensive list of real and confirmed issues/concerns in review-concerns.md as a task list.

Finally, make recommendations. Review the review-concerns.md and for each issue, do any additional investigation needed. Your goal in this step is a detailed and comprehensive document review-recommendations.md (task lists again) of things you think should be done. These can be super small and narrowly focused nit picks and they can be larger issues.

Again don't change ANY code. You should only be writing to the review-\_.md files.

Specific types of issues I'm concerned about (but you should not be limited to these):

- are there entirely unused files? unused functions?
- are there places where the apps/web/src/components/ui/ components exist but aren't being used in other files (e.g. people with vanilla html buttons instead of the Button component, and other things like that)
- is there unnecessary complexity in individual methods or files?
- is the code well and consistently organized?
- are there pointless code comments left behind by AI (e.g. //just removed some code that used to be here)
- does this code feel clean high quality and not "crap that was vibe coded by an AI"

Make a super detailed TODO list before you start. Use subagents judiciously since this is a large task, though whenever you use a subagent, give it a super detailed prompt so it knows exactly what to do and always reemphasize it should not change any code and should only document findings in whatever place you want it to do so. Note, you may need additional temporary documentation files as part of using subagents in parallel and that's ok as long as they are named review-temp-\_.md
