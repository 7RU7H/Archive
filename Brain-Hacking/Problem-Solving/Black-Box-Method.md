# Black Box Method

A [Black box](https://en.wikipedia.org/wiki/Black_box) *"is a system which can be viewed in terms of its inputs and outputs, without any knowledge of its internal workings."* As method, Black-boxing a concept to learn or solve a problem, is systemic methodology of testing the inputs and outputs to extrapolate the internal concepts encapsulated within a problem or complex concepts to learn about them from some source. In essence all new topics that you are trying to learn are blackboxes to begin with. Yes there are public resources that make those actually whiteboxes, but if you can't find them then are you really resources at your disposal. 

## Colin Galen's Advantages & Practicalities - Plus my additions

Advantages
- Work Quickly
- Lets you know where to look
- Lets you identify related problems
- Keep learning focused
- Good libraries for specific language, have detailed comments or description code
- Provides a high level rational to play with the problem
- Reason to stay organised
- Reason to note down the aspects of what are learning and apply [[Improve-Your-Learning]] techniques too
- Some problems should not be Black Boxed as they respond to interaction by making it impossible to solve - Firewalls, AV or any detection mechanism that is design to prevent you hacking it.

White Box is entirely knowable, black boxes are mostly unknownable? How can we know the unknowable? We can easily here are just a few ways:
- Are you documenting input and timelining
- Are you copying the original state of the blackbox to protect ourselves from state change
- Comparing 2 blackboxes copies at the original state at timed intervals is time a factor in a subcompoent of any internal function that utilizes 
- Are you accounting that the internal state is saved affecting the same input and creating new output?
- Can by input, output, errors, unexpected behaviour (timing attacks) deduce potential sub components to the blackbox
- What similar white box exist that would indicate that the blackbox has similar subcomponents?
- Can we side channel the blackbox
- Can capture the internal state and simulate actions or review data in isolation such that it won't affect the original blackbox

## References

[Colin Galen's Youtube Video](https://www.youtube.com/watch?v=RDzsrmMl48I)