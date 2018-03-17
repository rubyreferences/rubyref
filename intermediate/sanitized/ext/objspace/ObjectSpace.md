# ObjectSpace

The objspace library extends the ObjectSpace module and adds several methods
to get internal statistic information about object/memory management.

You need to `require `objspace'` to use this extension module.

Generally, you *SHOULD NOT* use this library if you do not know about the MRI
implementation.  Mainly, this library is for (memory) profiler developers and
MRI developers who need to know about MRI memory usage.