# Open3

Open3 grants you access to stdin, stdout, stderr and a thread to wait for the
child process when running another program. You can specify various
attributes, redirections, current directory, etc., of the program in the same
way as for Process.spawn.

*   Open3.popen3 : pipes for stdin, stdout, stderr
*   Open3.popen2 : pipes for stdin, stdout
*   Open3.popen2e : pipes for stdin, merged stdout and stderr
*   Open3.capture3 : give a string for stdin; get strings for stdout, stderr
*   Open3.capture2 : give a string for stdin; get a string for stdout
*   Open3.capture2e : give a string for stdin; get a string for merged stdout
    and stderr
*   Open3.pipeline_rw : pipes for first stdin and last stdout of a pipeline
*   Open3.pipeline_r : pipe for last stdout of a pipeline
*   Open3.pipeline_w : pipe for first stdin of a pipeline
*   Open3.pipeline_start : run a pipeline without waiting
*   Open3.pipeline : run a pipeline and wait for its completion


[Open3 Reference](https://ruby-doc.org/stdlib-2.6/libdoc/open3/rdoc/Open3.html)
