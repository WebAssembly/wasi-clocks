<h1><a name="example_world">World example-world</a></h1>
<ul>
<li>Imports:
<ul>
<li>interface <a href="#wasi:poll_poll"><code>wasi:poll/poll</code></a></li>
<li>interface <a href="#wasi:clocks_monotonic_clock"><code>wasi:clocks/monotonic-clock</code></a></li>
<li>interface <a href="#wasi:clocks_wall_clock"><code>wasi:clocks/wall-clock</code></a></li>
<li>interface <a href="#wasi:clocks_timezone"><code>wasi:clocks/timezone</code></a></li>
</ul>
</li>
</ul>
<h2><a name="wasi:poll_poll">Import interface wasi:poll/poll</a></h2>
<p>A poll API intended to let users wait for I/O events on multiple handles
at once.</p>
<hr />
<h3>Types</h3>
<h4><a name="pollable"><code>resource pollable</code></a></h4>
<h5>Resource Members</h5>
<p>TODO</p>
<hr />
<h3>Functions</h3>
<h4><a name="poll_oneoff"><code>poll-oneoff: func</code></a></h4>
<p>Poll for completion on a set of pollables.</p>
<p>The &quot;oneoff&quot; in the name refers to the fact that this function must do a
linear scan through the entire list of subscriptions, which may be
inefficient if the number is large and the same subscriptions are used
many times. In the future, this is expected to be obsoleted by the
component model async proposal, which will include a scalable waiting
facility.</p>
<p>The result list<bool> is the same length as the argument
list<pollable>, and indicates the readiness of each corresponding
element in that / list, with true indicating ready.</p>
<h5>Params</h5>
<ul>
<li><a name="poll_oneoff.in"><code>in</code></a>: list&lt;own&lt;<a href="#pollable"><a href="#pollable"><code>pollable</code></a></a>&gt;&gt;</li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="poll_oneoff.0"></a> list&lt;<code>bool</code>&gt;</li>
</ul>
<h2><a name="wasi:clocks_monotonic_clock">Import interface wasi:clocks/monotonic-clock</a></h2>
<p>WASI Monotonic Clock is a clock API intended to let users measure elapsed
time.</p>
<p>It is intended to be portable at least between Unix-family platforms and
Windows.</p>
<p>A monotonic clock is a clock which has an unspecified initial value, and
successive reads of the clock will produce non-decreasing values.</p>
<p>It is intended for measuring elapsed time.</p>
<hr />
<h3>Types</h3>
<h4><a name="pollable"><code>type pollable</code></a></h4>
<p><a href="#pollable"><a href="#pollable"><code>pollable</code></a></a></p>
<p>
#### <a name="instant">`type instant`</a>
`u64`
<p>A timestamp in nanoseconds.
<hr />
<h3>Functions</h3>
<h4><a name="now"><code>now: func</code></a></h4>
<p>Read the current value of the clock.</p>
<p>The clock is monotonic, therefore calling this function repeatedly will
produce a sequence of non-decreasing values.</p>
<h5>Return values</h5>
<ul>
<li><a name="now.0"></a> <a href="#instant"><a href="#instant"><code>instant</code></a></a></li>
</ul>
<h4><a name="resolution"><code>resolution: func</code></a></h4>
<p>Query the resolution of the clock.</p>
<h5>Return values</h5>
<ul>
<li><a name="resolution.0"></a> <a href="#instant"><a href="#instant"><code>instant</code></a></a></li>
</ul>
<h4><a name="subscribe"><code>subscribe: func</code></a></h4>
<p>Create a <a href="#pollable"><code>pollable</code></a> which will resolve once the specified time has been
reached.</p>
<h5>Params</h5>
<ul>
<li><a name="subscribe.when"><code>when</code></a>: <a href="#instant"><a href="#instant"><code>instant</code></a></a></li>
<li><a name="subscribe.absolute"><code>absolute</code></a>: <code>bool</code></li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="subscribe.0"></a> own&lt;<a href="#pollable"><a href="#pollable"><code>pollable</code></a></a>&gt;</li>
</ul>
<h2><a name="wasi:clocks_wall_clock">Import interface wasi:clocks/wall-clock</a></h2>
<p>WASI Wall Clock is a clock API intended to let users query the current
time. The name &quot;wall&quot; makes an analogy to a &quot;clock on the wall&quot;, which
is not necessarily monotonic as it may be reset.</p>
<p>It is intended to be portable at least between Unix-family platforms and
Windows.</p>
<p>A wall clock is a clock which measures the date and time according to
some external reference.</p>
<p>External references may be reset, so this clock is not necessarily
monotonic, making it unsuitable for measuring elapsed time.</p>
<p>It is intended for reporting the current date and time for humans.</p>
<hr />
<h3>Types</h3>
<h4><a name="datetime"><code>record datetime</code></a></h4>
<p>A time and date in seconds plus nanoseconds.</p>
<h5>Record Fields</h5>
<ul>
<li><a name="datetime.seconds"><code>seconds</code></a>: <code>u64</code></li>
<li><a name="datetime.nanoseconds"><code>nanoseconds</code></a>: <code>u32</code></li>
</ul>
<hr />
<h3>Functions</h3>
<h4><a name="now"><code>now: func</code></a></h4>
<p>Read the current value of the clock.</p>
<p>This clock is not monotonic, therefore calling this function repeatedly
will not necessarily produce a sequence of non-decreasing values.</p>
<p>The returned timestamps represent the number of seconds since
1970-01-01T00:00:00Z, also known as <a href="https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap04.html#tag_21_04_16">POSIX's Seconds Since the Epoch</a>,
also known as <a href="https://en.wikipedia.org/wiki/Unix_time">Unix Time</a>.</p>
<p>The nanoseconds field of the output is always less than 1000000000.</p>
<h5>Return values</h5>
<ul>
<li><a name="now.0"></a> <a href="#datetime"><a href="#datetime"><code>datetime</code></a></a></li>
</ul>
<h4><a name="resolution"><code>resolution: func</code></a></h4>
<p>Query the resolution of the clock.</p>
<p>The nanoseconds field of the output is always less than 1000000000.</p>
<h5>Return values</h5>
<ul>
<li><a name="resolution.0"></a> <a href="#datetime"><a href="#datetime"><code>datetime</code></a></a></li>
</ul>
<h2><a name="wasi:clocks_timezone">Import interface wasi:clocks/timezone</a></h2>
<hr />
<h3>Types</h3>
<h4><a name="datetime"><code>type datetime</code></a></h4>
<p><a href="#datetime"><a href="#datetime"><code>datetime</code></a></a></p>
<p>
#### <a name="timezone">`resource timezone`</a>
<h5>Resource Members</h5>
<p>TODO</p>
<h4><a name="timezone_display"><code>record timezone-display</code></a></h4>
<p>Information useful for displaying the timezone of a specific <a href="#datetime"><code>datetime</code></a>.</p>
<p>This information may vary within a single <a href="#timezone"><code>timezone</code></a> to reflect daylight
saving time adjustments.</p>
<h5>Record Fields</h5>
<ul>
<li>
<p><a name="timezone_display.utc_offset"><code>utc-offset</code></a>: <code>s32</code></p>
<p>The number of seconds difference between UTC time and the local
time of the timezone.
<p>The returned value will always be less than 86400 which is the
number of seconds in a day (24<em>60</em>60).</p>
<p>In implementations that do not expose an actual time zone, this
should return 0.</p>
</li>
<li>
<p><a name="timezone_display.name"><code>name</code></a>: <code>string</code></p>
<p>The abbreviated name of the timezone to display to a user. The name
`UTC` indicates Coordinated Universal Time. Otherwise, this should
reference local standards for the name of the time zone.
<p>In implementations that do not expose an actual time zone, this
should be the string <code>UTC</code>.</p>
<p>In time zones that do not have an applicable name, a formatted
representation of the UTC offset may be returned, such as <code>-04:00</code>.</p>
</li>
<li>
<p><a name="timezone_display.in_daylight_saving_time"><code>in-daylight-saving-time</code></a>: <code>bool</code></p>
<p>Whether daylight saving time is active.
<p>In implementations that do not expose an actual time zone, this
should return false.</p>
</li>
</ul>
<hr />
<h3>Functions</h3>
<h4><a name="method_timezone.display"><code>[method]timezone.display: func</code></a></h4>
<p>Return information needed to display the given <a href="#datetime"><code>datetime</code></a>. This includes
the UTC offset, the time zone name, and a flag indicating whether
daylight saving time is active.</p>
<p>If the timezone cannot be determined for the given <a href="#datetime"><code>datetime</code></a>, return a
<a href="#timezone_display"><code>timezone-display</code></a> for <code>UTC</code> with a <code>utc-offset</code> of 0 and no daylight
saving time.</p>
<h5>Params</h5>
<ul>
<li><a name="method_timezone.display.self"><code>self</code></a>: borrow&lt;<a href="#timezone"><a href="#timezone"><code>timezone</code></a></a>&gt;</li>
<li><a name="method_timezone.display.when"><code>when</code></a>: <a href="#datetime"><a href="#datetime"><code>datetime</code></a></a></li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="method_timezone.display.0"></a> <a href="#timezone_display"><a href="#timezone_display"><code>timezone-display</code></a></a></li>
</ul>
<h4><a name="method_timezone.utc_offset"><code>[method]timezone.utc-offset: func</code></a></h4>
<p>The same as <code>display</code>, but only return the UTC offset.</p>
<h5>Params</h5>
<ul>
<li><a name="method_timezone.utc_offset.self"><code>self</code></a>: borrow&lt;<a href="#timezone"><a href="#timezone"><code>timezone</code></a></a>&gt;</li>
<li><a name="method_timezone.utc_offset.when"><code>when</code></a>: <a href="#datetime"><a href="#datetime"><code>datetime</code></a></a></li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="method_timezone.utc_offset.0"></a> <code>s32</code></li>
</ul>
