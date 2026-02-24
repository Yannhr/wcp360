WCP360 First Boot &amp; One-Click Installation Architecture</h2>
<p data-start="235" data-end="278">This document describes how WCP360 handles:</p>

<ul data-start="280" data-end="445">
 	<li data-start="280" data-end="306">
<p data-start="282" data-end="306">One-click installation</p>
</li>
 	<li data-start="307" data-end="342">
<p data-start="309" data-end="342">Automatic system initialization</p>
</li>
 	<li data-start="343" data-end="383">
<p data-start="345" data-end="383">First login using server credentials</p>
</li>
 	<li data-start="384" data-end="403">
<p data-start="386" data-end="403">Admin bootstrap</p>
</li>
 	<li data-start="404" data-end="445">
<p data-start="406" data-end="445">Secure transition to normal operation</p>
</li>
</ul>
<p data-start="447" data-end="548">The objective is to provide a <strong data-start="477" data-end="547">fully automated, secure, and production-ready installation process</strong>.</p>


<hr data-start="550" data-end="553" />

<h1 data-start="555" data-end="572">1. Design Goals</h1>
<p data-start="574" data-end="601">The first boot system must:</p>

<ol data-start="603" data-end="1017">
 	<li data-start="603" data-end="644">
<p data-start="606" data-end="644">Require only one installation command.</p>
</li>
 	<li data-start="645" data-end="684">
<p data-start="648" data-end="684">Avoid manual database configuration.</p>
</li>
 	<li data-start="685" data-end="721">
<p data-start="688" data-end="721">Avoid manual config file editing.</p>
</li>
 	<li data-start="722" data-end="780">
<p data-start="725" data-end="780">Allow secure first login using server root credentials.</p>
</li>
 	<li data-start="781" data-end="829">
<p data-start="784" data-end="829">Automatically create the first admin account.</p>
</li>
 	<li data-start="830" data-end="866">
<p data-start="833" data-end="866">Create a default hosting package.</p>
</li>
 	<li data-start="867" data-end="899">
<p data-start="870" data-end="899">Enable required core modules.</p>
</li>
 	<li data-start="900" data-end="943">
<p data-start="903" data-end="943">Disable root login after initialization.</p>
</li>
 	<li data-start="944" data-end="978">
<p data-start="947" data-end="978">Be idempotent (safe to re-run).</p>
</li>
 	<li data-start="979" data-end="1017">
<p data-start="983" data-end="1017">Leave the system production-ready.</p>
</li>
</ol>

<hr data-start="1019" data-end="1022" />

<h1 data-start="1024" data-end="1056">2. One-Click Installation Flow</h1>
<p data-start="1058" data-end="1072">User executes:</p>

<div class="w-full my-4">
<div class="">
<div class="relative">
<div class="h-full min-h-0 min-w-0">
<div class="h-full min-h-0 min-w-0">
<div class="border corner-superellipse/1.1 border-token-border-light bg-token-bg-elevated-secondary rounded-3xl">
<div class="pointer-events-none absolute inset-x-4 top-12 bottom-4">
<div class="pointer-events-none sticky z-40 shrink-0 z-1!">
<div class="sticky bg-token-border-light"></div>
</div>
</div>
<div class="pointer-events-none absolute inset-x-px top-6 bottom-6">
<div class="sticky z-1!">
<div class="bg-token-bg-elevated-secondary sticky"></div>
</div>
</div>
<div class="corner-superellipse/1.1 rounded-3xl bg-token-bg-elevated-secondary">
<div class="relative z-0 flex max-w-full">
<div id="code-block-viewer" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼ5 ͼj" dir="ltr">
<div class="cm-scroller">
<div class="cm-content q9tKkq_readonly">curl -sSL https://install.wcp360.com | bash</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="">
<div class=""></div>
</div>
</div>
</div>
</div>
<p data-start="1127" data-end="1173">The installation performs the following steps.</p>


<hr data-start="1175" data-end="1178" />

<h2 data-start="1180" data-end="1209">Stage 1 — Preflight Checks</h2>
<p data-start="1211" data-end="1220">Validate:</p>

<ul data-start="1222" data-end="1358">
 	<li data-start="1222" data-end="1239">
<p data-start="1224" data-end="1239">Running as root</p>
</li>
 	<li data-start="1240" data-end="1270">
<p data-start="1242" data-end="1270">Supported Linux distribution</p>
</li>
 	<li data-start="1271" data-end="1291">
<p data-start="1273" data-end="1291">Minimum disk space</p>
</li>
 	<li data-start="1292" data-end="1305">
<p data-start="1294" data-end="1305">Minimum RAM</p>
</li>
 	<li data-start="1306" data-end="1332">
<p data-start="1308" data-end="1332">Required ports available</p>
</li>
 	<li data-start="1333" data-end="1358">
<p data-start="1335" data-end="1358">No conflicting services</p>
</li>
</ul>
<p data-start="1360" data-end="1413">If any requirement fails, installation aborts safely.</p>


<hr data-start="1415" data-end="1418" />

<h2 data-start="1420" data-end="1456">Stage 2 — Dependency Installation</h2>
<p data-start="1458" data-end="1484">Install required services:</p>

<ul data-start="1486" data-end="1597">
 	<li data-start="1486" data-end="1493">
<p data-start="1488" data-end="1493">Nginx</p>
</li>
 	<li data-start="1494" data-end="1517">
<p data-start="1496" data-end="1517">MariaDB or PostgreSQL</p>
</li>
 	<li data-start="1518" data-end="1552">
<p data-start="1520" data-end="1552">Redis (optional but recommended)</p>
</li>
 	<li data-start="1553" data-end="1581">
<p data-start="1555" data-end="1581">Systemd service definition</p>
</li>
 	<li data-start="1582" data-end="1597">
<p data-start="1584" data-end="1597">WCP360 binary</p>
</li>
</ul>

<hr data-start="1599" data-end="1602" />

<h2 data-start="1604" data-end="1635">Stage 3 — System Preparation</h2>
<ul data-start="1637" data-end="1841">
 	<li data-start="1637" data-end="1666">
<p data-start="1639" data-end="1666">Create system user <code data-start="1658" data-end="1666">wcp360</code></p>
</li>
 	<li data-start="1667" data-end="1693">
<p data-start="1669" data-end="1693">Create database and user</p>
</li>
 	<li data-start="1694" data-end="1729">
<p data-start="1696" data-end="1729">Generate secure database password</p>
</li>
 	<li data-start="1730" data-end="1761">
<p data-start="1732" data-end="1761">Generate platform secret keys</p>
</li>
 	<li data-start="1762" data-end="1795">
<p data-start="1764" data-end="1795">Write <code data-start="1770" data-end="1795">/etc/wcp360/config.yaml</code></p>
</li>
 	<li data-start="1796" data-end="1841">
<p data-start="1798" data-end="1841">Enable and start the WCP360 systemd service</p>
</li>
</ul>

<hr data-start="1843" data-end="1846" />

<h2 data-start="1848" data-end="1885">Stage 4 — Activate First Boot Mode</h2>
<p data-start="1887" data-end="1903">On first launch:</p>

<ul data-start="1905" data-end="2037">
 	<li data-start="1905" data-end="1935">
<p data-start="1907" data-end="1935"><code data-start="1907" data-end="1935">system_initialized = false</code></p>
</li>
 	<li data-start="1936" data-end="1961">
<p data-start="1938" data-end="1961">First boot mode enabled</p>
</li>
 	<li data-start="1962" data-end="1992">
<p data-start="1964" data-end="1992">Temporary root login allowed</p>
</li>
 	<li data-start="1993" data-end="2037">
<p data-start="1995" data-end="2037">Optional time limit for first boot session</p>
</li>
</ul>

<hr data-start="2039" data-end="2042" />

<h1 data-start="2044" data-end="2085">3. First Login Using Server Credentials</h1>
<p data-start="2087" data-end="2110">During first boot only:</p>

<ul data-start="2112" data-end="2198">
 	<li data-start="2112" data-end="2128">
<p data-start="2114" data-end="2128">Username: root</p>
</li>
 	<li data-start="2129" data-end="2161">
<p data-start="2131" data-end="2161">Password: system root password</p>
</li>
 	<li data-start="2162" data-end="2198">
<p data-start="2164" data-end="2198">Authentication performed using PAM</p>
</li>
</ul>
<p data-start="2200" data-end="2211">Conditions:</p>

<ul data-start="2213" data-end="2306">
 	<li data-start="2213" data-end="2247">
<p data-start="2215" data-end="2247">system_initialized must be false</p>
</li>
 	<li data-start="2248" data-end="2273">
<p data-start="2250" data-end="2273">Username must be "root"</p>
</li>
 	<li data-start="2274" data-end="2306">
<p data-start="2276" data-end="2306">First boot mode must be active</p>
</li>
</ul>
<p data-start="2308" data-end="2329">After initialization:</p>

<ul data-start="2331" data-end="2376">
 	<li data-start="2331" data-end="2376">
<p data-start="2333" data-end="2376">Root login via web is permanently disabled.</p>
</li>
</ul>

<hr data-start="2378" data-end="2381" />

<h1 data-start="2383" data-end="2407">4. Authentication Flow</h1>
<ol data-start="2409" data-end="2727">
 	<li data-start="2409" data-end="2433">
<p data-start="2412" data-end="2433">User opens web panel.</p>
</li>
 	<li data-start="2434" data-end="2466">
<p data-start="2437" data-end="2466">System checks if initialized.</p>
</li>
 	<li data-start="2467" data-end="2559">
<p data-start="2470" data-end="2489">If not initialized:</p>

<ul data-start="2493" data-end="2559">
 	<li data-start="2493" data-end="2522">
<p data-start="2495" data-end="2522">Only root login is allowed.</p>
</li>
 	<li data-start="2526" data-end="2559">
<p data-start="2528" data-end="2559">Root password verified via PAM.</p>
</li>
</ul>
</li>
 	<li data-start="2560" data-end="2621">
<p data-start="2563" data-end="2590">If authentication succeeds:</p>

<ul data-start="2594" data-end="2621">
 	<li data-start="2594" data-end="2621">
<p data-start="2596" data-end="2621">Bootstrap process begins.</p>
</li>
</ul>
</li>
 	<li data-start="2622" data-end="2660">
<p data-start="2625" data-end="2660">System marks itself as initialized.</p>
</li>
 	<li data-start="2661" data-end="2684">
<p data-start="2664" data-end="2684">Root login disabled.</p>
</li>
 	<li data-start="2685" data-end="2727">
<p data-start="2688" data-end="2727">Admin account login required afterward.</p>
</li>
</ol>

<hr data-start="2729" data-end="2732" />

<h1 data-start="2734" data-end="2756">5. Bootstrap Process</h1>
<p data-start="2758" data-end="2821">After successful root authentication, the system automatically:</p>

<ul data-start="2823" data-end="3035">
 	<li data-start="2823" data-end="2861">
<p data-start="2825" data-end="2861">Creates first internal admin account</p>
</li>
 	<li data-start="2862" data-end="2892">
<p data-start="2864" data-end="2892">Forces admin password change</p>
</li>
 	<li data-start="2893" data-end="2926">
<p data-start="2895" data-end="2926">Creates default hosting package</p>
</li>
 	<li data-start="2927" data-end="2953">
<p data-start="2929" data-end="2953">Enables required modules</p>
</li>
 	<li data-start="2954" data-end="3005">
<p data-start="2956" data-end="3005">Initializes database schema (if not already done)</p>
</li>
 	<li data-start="3006" data-end="3035">
<p data-start="3008" data-end="3035">Marks system as initialized</p>
</li>
</ul>
<p data-start="3037" data-end="3086">All actions must be transactional and idempotent.</p>


<hr data-start="3088" data-end="3091" />

<h1 data-start="3093" data-end="3127">6. Recommended Go Code Structure</h1>
<p data-start="3129" data-end="3146">Directory layout:</p>

<div class="w-full my-4">
<div class="">
<div class="relative">
<div class="h-full min-h-0 min-w-0">
<div class="h-full min-h-0 min-w-0">
<div class="border corner-superellipse/1.1 border-token-border-light bg-token-bg-elevated-secondary rounded-3xl">
<div class="pointer-events-none absolute inset-x-4 top-12 bottom-4">
<div class="pointer-events-none sticky z-40 shrink-0 z-1!">
<div class="sticky bg-token-border-light"></div>
</div>
</div>
<div class="pointer-events-none absolute inset-x-px top-6 bottom-6">
<div class="sticky z-1!">
<div class="bg-token-bg-elevated-secondary sticky"></div>
</div>
</div>
<div class="corner-superellipse/1.1 rounded-3xl bg-token-bg-elevated-secondary">
<div class="relative z-0 flex max-w-full">
<div id="code-block-viewer" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼ5 ͼj" dir="ltr">
<div class="cm-scroller">
<div class="cm-content q9tKkq_readonly">cmd/
wcpd/
wcp-cli/
wcp-bootstrap/core/
auth/
auth.go
pam.go
firstboot.go
bootstrap/
bootstrap.go
admin.go
packages.go
modules.go
system/
state.go
config/
config.go

internal/
installer/
preflight.go
dependencies.go

</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="">
<div class=""></div>
</div>
</div>
</div>
</div>

<hr data-start="3435" data-end="3438" />

<h1 data-start="3440" data-end="3468">7. System State Management</h1>
<p data-start="3470" data-end="3515">The system must persist initialization state:</p>
<p data-start="3517" data-end="3535">Example structure:</p>

<ul data-start="3537" data-end="3587">
 	<li data-start="3537" data-end="3560">
<p data-start="3539" data-end="3560">initialized (boolean)</p>
</li>
 	<li data-start="3561" data-end="3587">
<p data-start="3563" data-end="3587">installed_at (timestamp)</p>
</li>
</ul>
<p data-start="3589" data-end="3632">This prevents repeated bootstrap execution.</p>


<hr data-start="3634" data-end="3637" />

<h1 data-start="3639" data-end="3663">8. Security Safeguards</h1>
<p data-start="3665" data-end="3692">After first initialization:</p>

<ul data-start="3694" data-end="4018">
 	<li data-start="3694" data-end="3732">
<p data-start="3696" data-end="3732">Root web login permanently disabled.</p>
</li>
 	<li data-start="3733" data-end="3760">
<p data-start="3735" data-end="3760">First boot mode disabled.</p>
</li>
 	<li data-start="3761" data-end="3823">
<p data-start="3763" data-end="3823">PAM authentication not accessible through normal API routes.</p>
</li>
 	<li data-start="3824" data-end="3872">
<p data-start="3826" data-end="3872">All root login attempts logged in audit trail.</p>
</li>
 	<li data-start="3873" data-end="3920">
<p data-start="3875" data-end="3920">Optional: limit root login to localhost only.</p>
</li>
 	<li data-start="3921" data-end="3960">
<p data-start="3923" data-end="3960">Optional: enforce HTTPS before login.</p>
</li>
 	<li data-start="3961" data-end="4018">
<p data-start="3963" data-end="4018">Optional: require password change on first admin login.</p>
</li>
</ul>

<hr data-start="4020" data-end="4023" />

<h1 data-start="4025" data-end="4054">9. Idempotency Requirements</h1>
<p data-start="4056" data-end="4082">Bootstrap operations must:</p>

<ul data-start="4084" data-end="4245">
 	<li data-start="4084" data-end="4110">
<p data-start="4086" data-end="4110">Detect existing records.</p>
</li>
 	<li data-start="4111" data-end="4146">
<p data-start="4113" data-end="4146">Avoid duplicate package creation.</p>
</li>
 	<li data-start="4147" data-end="4180">
<p data-start="4149" data-end="4180">Avoid duplicate admin creation.</p>
</li>
 	<li data-start="4181" data-end="4209">
<p data-start="4183" data-end="4209">Use database transactions.</p>
</li>
 	<li data-start="4210" data-end="4245">
<p data-start="4212" data-end="4245">Be safe if partially interrupted.</p>
</li>
</ul>

<hr data-start="4247" data-end="4250" />

<h1 data-start="4252" data-end="4276">10. Final System State</h1>
<p data-start="4278" data-end="4299">After initialization:</p>

<ul data-start="4301" data-end="4489">
 	<li data-start="4301" data-end="4324">
<p data-start="4303" data-end="4324">Admin account exists.</p>
</li>
 	<li data-start="4325" data-end="4358">
<p data-start="4327" data-end="4358">Default hosting package exists.</p>
</li>
 	<li data-start="4359" data-end="4382">
<p data-start="4361" data-end="4382">Core modules enabled.</p>
</li>
 	<li data-start="4383" data-end="4409">
<p data-start="4385" data-end="4409">Configuration generated.</p>
</li>
 	<li data-start="4410" data-end="4429">
<p data-start="4412" data-end="4429">Services running.</p>
</li>
 	<li data-start="4430" data-end="4452">
<p data-start="4432" data-end="4452">Root login disabled.</p>
</li>
 	<li data-start="4453" data-end="4489">
<p data-start="4455" data-end="4489">Platform ready for production use.</p>
</li>
</ul>

<hr data-start="4491" data-end="4494" />

<h1 data-start="4496" data-end="4526">11. Architectural Guarantees</h1>
<ul data-start="4528" data-end="4747">
 	<li data-start="4528" data-end="4565">
<p data-start="4530" data-end="4565">Zero manual configuration required.</p>
</li>
 	<li data-start="4566" data-end="4596">
<p data-start="4568" data-end="4596">Secure root-based bootstrap.</p>
</li>
 	<li data-start="4597" data-end="4628">
<p data-start="4599" data-end="4628">No persistent root web login.</p>
</li>
 	<li data-start="4629" data-end="4660">
<p data-start="4631" data-end="4660">Fully automated installation.</p>
</li>
 	<li data-start="4661" data-end="4698">
<p data-start="4663" data-end="4698">Safe and repeatable initialization.</p>
</li>
 	<li data-start="4699" data-end="4747">
<p data-start="4701" data-end="4747">Clean transition to RBAC-based authentication.</p>
</li>
</ul>

<hr data-start="4749" data-end="4752" />
<p data-start="4754" data-end="4883">This architecture ensures that WCP360 can be installed with a single command and securely initialized without manual setup steps.
