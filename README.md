# CodeableGenericBug

This project illustrates a compiler or framework issue with Swift 4 and iOS 10.  It occurs when deserializing generics in nested structs using the Codable interface.

## Context

The use-case that uncovered this bug is as follows:

1. An external service returns JSON models like `Foo` and `Bar`
2. The service returns all models in a common wrapper so that `response.data.attributes` is the actual thing we want (i.e. `Foo`)

    2a. It does this so things like metadata, filters, links, etc can also be returned in a consistent manner within the same response
3. These models mirror the structures we want in our iOS client
4. To avoid redundant work, we'd like to use the `Codable` interface and built-in `JSONDecoder` to parse service responses
5. When creating a reusable wrapper to parse service responses, a runtime error is triggered

    5a. "cyclic metadata dependency detected"


## How to use this project

All three scenarios are isolated as unit tests.

1. Open `CodableGenericBugTests.swift` in XCode
2. Click the diamond to run all tests

![](run_tests.png "Run Tests")

## Expected vs Actual Behavior

### Expected Behavior
* All 3 unit tests pass.
* The structs `FooWrapper`, `GenericWrapper`, and `WorkingGenericWrapper` all behave in functionally-equivalent ways with regards to encoding and decoding

### Actual Behavior
` One unit test fails
* The struct `GenericWrapper` triggers a runtime error when using it in `JSONDecoder.decode()`

## Scenarios in scope

Three scenarios are tested in the following order:

* A reference scenario of using a Codable wrapper object.
* A broken scenario that re-uses the Codable wrapper object, but with a generic reference on the inner struct
* A workaround scenario that successfully uses generic wrappers, but does so by not defining the inner struct inline

## Comparisons

* `FooWrapper` (working) vs `GenericWrapper` (broken)
* The only difference between the two is that "data" is typed as `Foo` on the left and as `T` (generic) on the right
* The left struct works fine for our use case.  The right struct causes a runtime error when decoding.

![](specific_vs_generic.png "Specific vs Generic")

* `GenericWrapper` (broken) vs `WorkingGenericWrapper` (working)
* The only difference between the two is that one has nested structs defined inline, while the other defines a second struct externally
* The right side can be considered a work-around for the bug triggered by the left side

![](internal_vs_external.png "Internal vs External")

