# RSDTestApp
RSDTestApp contains example applications for running the surveys and async recorders included in the
ResearchStack2 and ResearchStack2UI frameworks. There are two test targets.

RSDTestApp is set up to test that a light-weight app with no required permissions can be built and
submitted to the Apple App Store without requiring set up of the unused privacy keys. Examples of
form steps and instruction steps that *do not* use any additional frameworks such as HealthKit,
CoreMotion, or CoreLocation can be added to this target when submitted as additions to the
ResearchStack2 and ResearchStack2UI frameworks, but submission of an example to this target is not
required.

RSDCatalog is set up as a catalog of example tasks for all the tasks, steps, async actions, etc. that
are included in the ResearchStack2 and ResearchStack2UI frameworks. When submitting an addition
to these frameworks, as a part of your submission, please include an example in the catalog as a
new task, add the task to the main task group JSON file, and add a UI Test to the UI test framework.

## License

ResearchStack2UI is available under the BSD license:

Copyright (c) 2017-2018, Sage Bionetworks
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
* Neither the name of Sage Bionetworks nor the names of BridgeSDk's
contributors may be used to endorse or promote products derived from
this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
