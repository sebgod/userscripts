




<!DOCTYPE html>
<html class="   ">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    
    <title>MatchTag/ftplugin/html.vim at master · gregsexton/MatchTag · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png" />
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png" />
    <meta property="fb:app_id" content="1401488693436528"/>

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="gregsexton/MatchTag" name="twitter:title" /><meta content="MatchTag - Vim&amp;#39;s MatchParen for HTML tags" name="twitter:description" /><meta content="https://avatars0.githubusercontent.com/u/150883?s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars0.githubusercontent.com/u/150883?s=400" property="og:image" /><meta content="gregsexton/MatchTag" property="og:title" /><meta content="https://github.com/gregsexton/MatchTag" property="og:url" /><meta content="MatchTag - Vim&#39;s MatchParen for HTML tags" property="og:description" />

    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035">
    

    <meta name="msapplication-TileImage" content="/windows-tile.png" />
    <meta name="msapplication-TileColor" content="#ffffff" />
    <meta name="selected-link" value="repo_source" data-pjax-transient />
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="59F5D15D:4859:1460EB2:53B66D95" name="octolytics-dimension-request_id" />
    

    
    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico" />


    <meta content="authenticity_token" name="csrf-param" />
<meta content="HYthGSWAWUyAyOSGHodk7LFbcGnm6c18qvbRVr8OfBlFJZ9us3RxxyKha3+WYNp3dmQJ1hVoegW1X2pzwmRoew==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-a3943029fb2330481c4a6367eccd68e84b5cb8d7.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://assets-cdn.github.com/assets/github2-a9fea911d10e4a2d622e7a566480b3fd2871c877.css" media="all" rel="stylesheet" type="text/css" />
    


    <meta http-equiv="x-pjax-version" content="63f5ce42ea1aad1881d2e7b634a534fc">

      
  <meta name="description" content="MatchTag - Vim&#39;s MatchParen for HTML tags" />


  <meta content="150883" name="octolytics-dimension-user_id" /><meta content="gregsexton" name="octolytics-dimension-user_login" /><meta content="2830211" name="octolytics-dimension-repository_id" /><meta content="gregsexton/MatchTag" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="2830211" name="octolytics-dimension-repository_network_root_id" /><meta content="gregsexton/MatchTag" name="octolytics-dimension-repository_network_root_nwo" />

  <link href="https://github.com/gregsexton/MatchTag/commits/master.atom" rel="alternate" title="Recent Commits to MatchTag:master" type="application/atom+xml" />

  </head>


  <body class="logged_out  env-production  vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      
      <div class="header header-logged-out">
  <div class="container clearfix">

    <a class="header-logo-wordmark" href="https://github.com/">
      <span class="mega-octicon octicon-logo-github"></span>
    </a>

    <div class="header-actions">
        <a class="button primary" href="/join">Sign up</a>
      <a class="button signin" href="/login?return_to=%2Fgregsexton%2FMatchTag%2Fblob%2Fmaster%2Fftplugin%2F%2Fhtml.vim">Sign in</a>
    </div>

    <div class="command-bar js-command-bar  in-repository">

      <ul class="top-nav">
          <li class="explore"><a href="/explore">Explore</a></li>
          <li class="features"><a href="/features">Features</a></li>
          <li class="enterprise"><a href="https://enterprise.github.com/">Enterprise</a></li>
          <li class="blog"><a href="/blog">Blog</a></li>
      </ul>
        <form accept-charset="UTF-8" action="/search" class="command-bar-form" id="top_search_form" method="get">

<div class="commandbar">
  <span class="message"></span>
  <input type="text" data-hotkey="s, /" name="q" id="js-command-bar-field" placeholder="Search or type a command" tabindex="1" autocapitalize="off"
    
    
      data-repo="gregsexton/MatchTag"
      data-branch="master"
      data-sha="75c467f5480b784db48f6d297476c11ae37f52fa"
  >
  <div class="display hidden"></div>
</div>

    <input type="hidden" name="nwo" value="gregsexton/MatchTag" />

    <div class="select-menu js-menu-container js-select-menu search-context-select-menu">
      <span class="minibutton select-menu-button js-menu-target" role="button" aria-haspopup="true">
        <span class="js-select-button">This repository</span>
      </span>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container" aria-hidden="true">
        <div class="select-menu-modal">

          <div class="select-menu-item js-navigation-item js-this-repository-navigation-item selected">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" class="js-search-this-repository" name="search_target" value="repository" checked="checked" />
            <div class="select-menu-item-text js-select-button-text">This repository</div>
          </div> <!-- /.select-menu-item -->

          <div class="select-menu-item js-navigation-item js-all-repositories-navigation-item">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" name="search_target" value="global" />
            <div class="select-menu-item-text js-select-button-text">All repositories</div>
          </div> <!-- /.select-menu-item -->

        </div>
      </div>
    </div>

  <span class="help tooltipped tooltipped-s" aria-label="Show command bar help">
    <span class="octicon octicon-question"></span>
  </span>


  <input type="hidden" name="ref" value="cmdform">

</form>
    </div>

  </div>
</div>



      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        
<ul class="pagehead-actions">


  <li>
      <a href="/login?return_to=%2Fgregsexton%2FMatchTag"
    class="minibutton with-count star-button tooltipped tooltipped-n"
    aria-label="You must be signed in to star a repository" rel="nofollow">
    <span class="octicon octicon-star"></span>
    Star
  </a>

    <a class="social-count js-social-count" href="/gregsexton/MatchTag/stargazers">
      144
    </a>

  </li>

    <li>
      <a href="/login?return_to=%2Fgregsexton%2FMatchTag"
        class="minibutton with-count js-toggler-target fork-button tooltipped tooltipped-n"
        aria-label="You must be signed in to fork a repository" rel="nofollow">
        <span class="octicon octicon-repo-forked"></span>
        Fork
      </a>
      <a href="/gregsexton/MatchTag/network" class="social-count">
        16
      </a>
    </li>
</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="repo-label"><span>public</span></span>
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/gregsexton" class="url fn" itemprop="url" rel="author"><span itemprop="title">gregsexton</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/gregsexton/MatchTag" class="js-current-repository js-repo-home-link">MatchTag</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline js-new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            

<div class="sunken-menu vertical-right repo-nav js-repo-nav js-repository-container-pjax js-octicon-loaders">
  <div class="sunken-menu-contents">
    <ul class="sunken-menu-group">
      <li class="tooltipped tooltipped-w" aria-label="Code">
        <a href="/gregsexton/MatchTag" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /gregsexton/MatchTag">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped tooltipped-w" aria-label="Issues">
          <a href="/gregsexton/MatchTag/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g i" data-selected-links="repo_issues /gregsexton/MatchTag/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class='counter'>5</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
        <a href="/gregsexton/MatchTag/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g p" data-selected-links="repo_pulls /gregsexton/MatchTag/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class='counter'>1</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


    </ul>
    <div class="sunken-menu-separator"></div>
    <ul class="sunken-menu-group">

      <li class="tooltipped tooltipped-w" aria-label="Pulse">
        <a href="/gregsexton/MatchTag/pulse" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="pulse /gregsexton/MatchTag/pulse">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Graphs">
        <a href="/gregsexton/MatchTag/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_graphs repo_contributors /gregsexton/MatchTag/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Network">
        <a href="/gregsexton/MatchTag/network" aria-label="Network" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-selected-links="repo_network /gregsexton/MatchTag/network">
          <span class="octicon octicon-repo-forked"></span> <span class="full-word">Network</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>


  </div>
</div>

              <div class="only-with-full-nav">
                

  

<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><strong>HTTPS</strong> clone URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/gregsexton/MatchTag.git" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/gregsexton/MatchTag.git" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  

<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><strong>Subversion</strong> checkout URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/gregsexton/MatchTag" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/gregsexton/MatchTag" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <a href="https://help.github.com/articles/which-remote-url-should-i-use" class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <span class="octicon octicon-question"></span>
  </a>
</p>



                <a href="/gregsexton/MatchTag/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download gregsexton/MatchTag as a zip file"
                   title="Download gregsexton/MatchTag as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          


<a href="/gregsexton/MatchTag/blob/6dfdab1530d47b77a1839b9477f27c33a2f10b26/ftplugin/html.vim" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:0b11603d6adf93db045d1183711a7676 -->

<p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

<div class="file-navigation">
  

<div class="select-menu js-menu-container js-select-menu" >
  <span class="minibutton select-menu-button js-menu-target css-truncate" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    title="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button css-truncate-target">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/gregsexton/MatchTag/blob/master/ftplugin//html.vim"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="button-group right">
    <a href="/gregsexton/MatchTag/find/master"
          class="js-show-file-finder minibutton empty-icon tooltipped tooltipped-s"
          data-pjax
          data-hotkey="t"
          aria-label="Quickly jump between files">
      <span class="octicon octicon-list-unordered"></span>
    </a>
    <button class="js-zeroclipboard minibutton zeroclipboard-button"
          data-clipboard-text="ftplugin/html.vim"
          aria-label="Copy to clipboard"
          data-copied-hint="Copied!">
      <span class="octicon octicon-clippy"></span>
    </button>
  </div>

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/gregsexton/MatchTag" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">MatchTag</span></a></span></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/gregsexton/MatchTag/tree/master/ftplugin" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">ftplugin</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/gregsexton/MatchTag/tree/master/ftplugin" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title"></span></a></span><span class="separator"> / </span><strong class="final-path">html.vim</strong>
  </div>
</div>


  <div class="commit file-history-tease">
      <img alt="Greg Sexton" class="main-avatar js-avatar" data-user="150883" height="24" src="https://avatars3.githubusercontent.com/u/150883?s=140" width="24" />
      <span class="author"><a href="/gregsexton" rel="author">gregsexton</a></span>
      <time datetime="2013-05-04T09:55:29+01:00" is="relative-time">May 04, 2013</time>
      <div class="commit-title">
          <a href="/gregsexton/MatchTag/commit/6dfdab1530d47b77a1839b9477f27c33a2f10b26" class="message" data-pjax="true" title="Merge pull request #18 from inkarkat/enh-multiline-tags

Conflicts:
	ftplugin/html.vim">Merge pull request</a> <a href="https://github.com/gregsexton/MatchTag/pull/18" class="issue-link" title="ENH: Support tags that span multiple lines.">#18</a> <a href="/gregsexton/MatchTag/commit/6dfdab1530d47b77a1839b9477f27c33a2f10b26" class="message" data-pjax="true" title="Merge pull request #18 from inkarkat/enh-multiline-tags

Conflicts:
	ftplugin/html.vim">from inkarkat/enh-multiline-tags</a>
      </div>

    <div class="participation">
      <p class="quickstat"><a href="#blob_contributors_box" rel="facebox"><strong>3</strong>  contributors</a></p>
          <a class="avatar tooltipped tooltipped-s" aria-label="inkarkat" href="/gregsexton/MatchTag/commits/master/ftplugin/html.vim?author=inkarkat"><img alt="Ingo Karkat" class=" js-avatar" data-user="181261" height="20" src="https://avatars3.githubusercontent.com/u/181261?s=140" width="20" /></a>
    <a class="avatar tooltipped tooltipped-s" aria-label="gregsexton" href="/gregsexton/MatchTag/commits/master/ftplugin/html.vim?author=gregsexton"><img alt="Greg Sexton" class=" js-avatar" data-user="150883" height="20" src="https://avatars3.githubusercontent.com/u/150883?s=140" width="20" /></a>
    <a class="avatar tooltipped tooltipped-s" aria-label="mattsacks" href="/gregsexton/MatchTag/commits/master/ftplugin/html.vim?author=mattsacks"><img alt="Matt Sacks" class=" js-avatar" data-user="194567" height="20" src="https://avatars0.githubusercontent.com/u/194567?s=140" width="20" /></a>


    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list">
          <li class="facebox-user-list-item">
            <img alt="Ingo Karkat" class=" js-avatar" data-user="181261" height="24" src="https://avatars3.githubusercontent.com/u/181261?s=140" width="24" />
            <a href="/inkarkat">inkarkat</a>
          </li>
          <li class="facebox-user-list-item">
            <img alt="Greg Sexton" class=" js-avatar" data-user="150883" height="24" src="https://avatars3.githubusercontent.com/u/150883?s=140" width="24" />
            <a href="/gregsexton">gregsexton</a>
          </li>
          <li class="facebox-user-list-item">
            <img alt="Matt Sacks" class=" js-avatar" data-user="194567" height="24" src="https://avatars0.githubusercontent.com/u/194567?s=140" width="24" />
            <a href="/mattsacks">mattsacks</a>
          </li>
      </ul>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
        <span class="icon"><b class="octicon octicon-file-text"></b></span>
        <span class="mode" title="File Mode">file</span>
        <span class="meta-divider"></span>
          <span>100 lines (83 sloc)</span>
          <span class="meta-divider"></span>
        <span>3.594 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
              <a class="minibutton disabled tooltipped tooltipped-w" href="#"
                 aria-label="You must be signed in to make or propose changes">Edit</a>
          <a href="/gregsexton/MatchTag/raw/master/ftplugin/html.vim" class="minibutton " id="raw-url">Raw</a>
            <a href="/gregsexton/MatchTag/blame/master/ftplugin/html.vim" class="minibutton js-update-url-with-hash">Blame</a>
          <a href="/gregsexton/MatchTag/commits/master/ftplugin/html.vim" class="minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->
          <a class="minibutton danger disabled empty-icon tooltipped tooltipped-w" href="#"
             aria-label="You must be signed in to make or propose changes">
          Delete
        </a>
      </div><!-- /.actions -->
    </div>
      
  <div class="blob-wrapper data type-viml js-blob-data">
       <table class="file-code file-diff tab-size-8">
         <tr class="file-code-line">
           <td class="blob-line-nums">
             <span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>
<span id="L60" rel="#L60">60</span>
<span id="L61" rel="#L61">61</span>
<span id="L62" rel="#L62">62</span>
<span id="L63" rel="#L63">63</span>
<span id="L64" rel="#L64">64</span>
<span id="L65" rel="#L65">65</span>
<span id="L66" rel="#L66">66</span>
<span id="L67" rel="#L67">67</span>
<span id="L68" rel="#L68">68</span>
<span id="L69" rel="#L69">69</span>
<span id="L70" rel="#L70">70</span>
<span id="L71" rel="#L71">71</span>
<span id="L72" rel="#L72">72</span>
<span id="L73" rel="#L73">73</span>
<span id="L74" rel="#L74">74</span>
<span id="L75" rel="#L75">75</span>
<span id="L76" rel="#L76">76</span>
<span id="L77" rel="#L77">77</span>
<span id="L78" rel="#L78">78</span>
<span id="L79" rel="#L79">79</span>
<span id="L80" rel="#L80">80</span>
<span id="L81" rel="#L81">81</span>
<span id="L82" rel="#L82">82</span>
<span id="L83" rel="#L83">83</span>
<span id="L84" rel="#L84">84</span>
<span id="L85" rel="#L85">85</span>
<span id="L86" rel="#L86">86</span>
<span id="L87" rel="#L87">87</span>
<span id="L88" rel="#L88">88</span>
<span id="L89" rel="#L89">89</span>
<span id="L90" rel="#L90">90</span>
<span id="L91" rel="#L91">91</span>
<span id="L92" rel="#L92">92</span>
<span id="L93" rel="#L93">93</span>
<span id="L94" rel="#L94">94</span>
<span id="L95" rel="#L95">95</span>
<span id="L96" rel="#L96">96</span>
<span id="L97" rel="#L97">97</span>
<span id="L98" rel="#L98">98</span>
<span id="L99" rel="#L99">99</span>
<span id="L100" rel="#L100">100</span>

           </td>
           <td class="blob-line-code"><div class="code-body highlight"><pre><div class='line' id='LC1'><span class="c">&quot; Vim plugin for showing matching html tags.</span></div><div class='line' id='LC2'><span class="c">&quot; Maintainer:  Greg Sexton &lt;gregsexton@gmail.com&gt;</span></div><div class='line' id='LC3'><span class="c">&quot; Credits: Bram Moolenar and the &#39;matchparen&#39; plugin from which this draws heavily.</span></div><div class='line' id='LC4'><br/></div><div class='line' id='LC5'><span class="k">if</span> exists<span class="p">(</span><span class="s2">&quot;b:did_ftplugin&quot;</span><span class="p">)</span></div><div class='line' id='LC6'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">finish</span></div><div class='line' id='LC7'><span class="k">endif</span></div><div class='line' id='LC8'><br/></div><div class='line' id='LC9'>augroup matchhtmlparen</div><div class='line' id='LC10'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">autocmd</span><span class="p">!</span> <span class="nb">CursorMoved</span><span class="p">,</span><span class="nb">CursorMovedI</span><span class="p">,</span><span class="nb">WinEnter</span> <span class="p">&lt;</span>buffer<span class="p">&gt;</span> <span class="k">call</span> <span class="k">s</span>:Highlight_Matching_Pair<span class="p">()</span></div><div class='line' id='LC11'>augroup END</div><div class='line' id='LC12'><br/></div><div class='line' id='LC13'><span class="k">fu</span><span class="p">!</span> <span class="k">s</span>:Highlight_Matching_Pair<span class="p">()</span></div><div class='line' id='LC14'><span class="c">    &quot; Remove any previous match.</span></div><div class='line' id='LC15'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> exists<span class="p">(</span><span class="s1">&#39;w:tag_hl_on&#39;</span><span class="p">)</span> &amp;&amp; <span class="k">w</span>:tag_hl_on</div><div class='line' id='LC16'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="m">2</span>match none</div><div class='line' id='LC17'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> <span class="k">w</span>:tag_hl_on <span class="p">=</span> <span class="m">0</span></div><div class='line' id='LC18'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">endif</span></div><div class='line' id='LC19'><br/></div><div class='line' id='LC20'><span class="c">    &quot; Avoid that we remove the popup menu.</span></div><div class='line' id='LC21'><span class="c">    &quot; Return when there are no colors (looks like the cursor jumps).</span></div><div class='line' id='LC22'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> pumvisible<span class="p">()</span> <span class="p">||</span> <span class="p">(</span>&amp;<span class="nb">t_Co</span> <span class="p">&lt;</span> <span class="m">8</span> &amp;&amp; <span class="p">!</span>has<span class="p">(</span><span class="s2">&quot;gui_running&quot;</span><span class="p">))</span></div><div class='line' id='LC23'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span></div><div class='line' id='LC24'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">endif</span></div><div class='line' id='LC25'><br/></div><div class='line' id='LC26'><span class="c">    &quot;get html tag under cursor</span></div><div class='line' id='LC27'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> tagname <span class="p">=</span> <span class="k">s</span>:GetCurrentCursorTag<span class="p">()</span></div><div class='line' id='LC28'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> tagname <span class="p">==</span> <span class="s2">&quot;&quot;</span><span class="p">|</span><span class="k">return</span><span class="p">|</span><span class="k">endif</span></div><div class='line' id='LC29'><br/></div><div class='line' id='LC30'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> tagname[<span class="m">0</span>] <span class="p">==</span> <span class="s1">&#39;/&#39;</span></div><div class='line' id='LC31'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> position <span class="p">=</span> <span class="k">s</span>:SearchForMatchingTag<span class="p">(</span>tagname[<span class="m">1</span>:]<span class="p">,</span> <span class="m">0</span><span class="p">)</span></div><div class='line' id='LC32'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">else</span></div><div class='line' id='LC33'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> position <span class="p">=</span> <span class="k">s</span>:SearchForMatchingTag<span class="p">(</span>tagname<span class="p">,</span> <span class="m">1</span><span class="p">)</span></div><div class='line' id='LC34'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">endif</span></div><div class='line' id='LC35'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">call</span> <span class="k">s</span>:HighlightTagAtPosition<span class="p">(</span>position<span class="p">)</span></div><div class='line' id='LC36'>endfu</div><div class='line' id='LC37'><br/></div><div class='line' id='LC38'><span class="k">fu</span><span class="p">!</span> <span class="k">s</span>:GetCurrentCursorTag<span class="p">()</span></div><div class='line' id='LC39'><span class="c">    &quot;returns the tag under the cursor, includes the &#39;/&#39; if on a closing tag.</span></div><div class='line' id='LC40'><br/></div><div class='line' id='LC41'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> c_col  <span class="p">=</span> <span class="k">col</span><span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">)</span></div><div class='line' id='LC42'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> matched <span class="p">=</span> matchstr<span class="p">(</span>getline<span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">),</span> <span class="s1">&#39;\(&lt;[^&lt;&gt;]*\%&#39;</span>.c_col.<span class="s1">&#39;c.\{-}&gt;\)\|\(\%&#39;</span>.c_col.<span class="s1">&#39;c&lt;.\{-}&gt;\)&#39;</span><span class="p">)</span></div><div class='line' id='LC43'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> matched <span class="p">=~</span> <span class="s1">&#39;/&gt;$&#39;</span></div><div class='line' id='LC44'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="s2">&quot;&quot;</span></div><div class='line' id='LC45'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">elseif</span> matched <span class="p">==</span> <span class="s2">&quot;&quot;</span></div><div class='line' id='LC46'><span class="c">        &quot; The tag itself may be spread over multiple lines.</span></div><div class='line' id='LC47'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> matched <span class="p">=</span> matchstr<span class="p">(</span>getline<span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">),</span> <span class="s1">&#39;\(&lt;[^&lt;&gt;]*\%&#39;</span>.c_col.<span class="s1">&#39;c.\{-}$\)\|\(\%&#39;</span>.c_col.<span class="s1">&#39;c&lt;.\{-}$\)&#39;</span><span class="p">)</span></div><div class='line' id='LC48'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> matched <span class="p">==</span> <span class="s2">&quot;&quot;</span></div><div class='line' id='LC49'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="s2">&quot;&quot;</span></div><div class='line' id='LC50'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">endif</span></div><div class='line' id='LC51'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">endif</span></div><div class='line' id='LC52'><br/></div><div class='line' id='LC53'><span class="c">    &quot; XML Tag definition is</span></div><div class='line' id='LC54'><span class="c">    &quot;   (Letter | &#39;_&#39; | &#39;:&#39;) (Letter | Digit | &#39;.&#39; | &#39;-&#39; | &#39;_&#39; | &#39;:&#39; | CombiningChar | Extender)*</span></div><div class='line' id='LC55'><span class="c">    &quot; Instead of dealing with CombiningChar and Extender, and because Vim&#39;s</span></div><div class='line' id='LC56'><span class="c">    &quot; [:alpha:] only includes 8-bit characters, let&#39;s include all non-ASCII</span></div><div class='line' id='LC57'><span class="c">    &quot; characters.</span></div><div class='line' id='LC58'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> tagname <span class="p">=</span> matchstr<span class="p">(</span>matched<span class="p">,</span> <span class="s1">&#39;&lt;\zs/\?\%([[:alpha:]_:]\|[^\x00-\x7F]\)\%([-._:[:alnum:]]\|[^\x00-\x7F]\)*&#39;</span><span class="p">)</span></div><div class='line' id='LC59'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> tagname</div><div class='line' id='LC60'>endfu</div><div class='line' id='LC61'><br/></div><div class='line' id='LC62'><span class="k">fu</span><span class="p">!</span> <span class="k">s</span>:SearchForMatchingTag<span class="p">(</span>tagname<span class="p">,</span> forwards<span class="p">)</span></div><div class='line' id='LC63'><span class="c">    &quot;returns the position of a matching tag or [0 0]</span></div><div class='line' id='LC64'><br/></div><div class='line' id='LC65'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> starttag <span class="p">=</span> <span class="s1">&#39;\V&lt;&#39;</span>.escape<span class="p">(</span><span class="k">a</span>:tagname<span class="p">,</span> <span class="s1">&#39;\&#39;</span><span class="p">)</span>.<span class="s1">&#39;\%(\_s\%(\.\{-}\|\_.\{-}\%&lt;&#39;</span>.line<span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">)</span>.<span class="s1">&#39;l\)/\@&lt;!\)\?&gt;&#39;</span></div><div class='line' id='LC66'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> midtag <span class="p">=</span> <span class="s1">&#39;&#39;</span></div><div class='line' id='LC67'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> endtag <span class="p">=</span> <span class="s1">&#39;\V&lt;/&#39;</span>.escape<span class="p">(</span><span class="k">a</span>:tagname<span class="p">,</span> <span class="s1">&#39;\&#39;</span><span class="p">)</span>.<span class="s1">&#39;\_s\*&#39;</span>.<span class="p">(</span><span class="k">a</span>:forwards?<span class="s1">&#39;&#39;</span>:<span class="s1">&#39;\zs&#39;</span><span class="p">)</span>.<span class="s1">&#39;&gt;&#39;</span></div><div class='line' id='LC68'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> flags <span class="p">=</span> <span class="s1">&#39;nW&#39;</span>.<span class="p">(</span><span class="k">a</span>:forwards?<span class="s1">&#39;&#39;</span>:<span class="s1">&#39;b&#39;</span><span class="p">)</span></div><div class='line' id='LC69'><br/></div><div class='line' id='LC70'><span class="c">    &quot; When not in a string or comment ignore matches inside them.</span></div><div class='line' id='LC71'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> skip <span class="p">=</span><span class="s1">&#39;synIDattr(synID(line(&quot;.&quot;), col(&quot;.&quot;), 0), &quot;name&quot;) &#39;</span> .</div><div class='line' id='LC72'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\ <span class="s1">&#39;=~?  &quot;\\%(html\\|xml\\)String\\|\\%(html\\|xml\\)CommentPart&quot;&#39;</span></div><div class='line' id='LC73'>&nbsp;&nbsp;&nbsp;&nbsp;execute <span class="s1">&#39;if&#39;</span> skip <span class="s1">&#39;| let skip = 0 | endif&#39;</span></div><div class='line' id='LC74'><br/></div><div class='line' id='LC75'><span class="c">    &quot; Limit the search to lines visible in the window.</span></div><div class='line' id='LC76'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> stopline <span class="p">=</span> <span class="k">a</span>:forwards ? line<span class="p">(</span><span class="s1">&#39;w$&#39;</span><span class="p">)</span> : line<span class="p">(</span><span class="s1">&#39;w0&#39;</span><span class="p">)</span></div><div class='line' id='LC77'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> <span class="nb">timeout</span> <span class="p">=</span> <span class="m">300</span></div><div class='line' id='LC78'><br/></div><div class='line' id='LC79'><span class="c">    &quot; The searchpairpos() timeout parameter was added in 7.2</span></div><div class='line' id='LC80'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="k">v</span>:<span class="k">version</span> <span class="p">&gt;=</span> <span class="m">702</span></div><div class='line' id='LC81'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> searchpairpos<span class="p">(</span>starttag<span class="p">,</span> midtag<span class="p">,</span> endtag<span class="p">,</span> flags<span class="p">,</span> skip<span class="p">,</span> stopline<span class="p">,</span> <span class="nb">timeout</span><span class="p">)</span></div><div class='line' id='LC82'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">else</span></div><div class='line' id='LC83'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> searchpairpos<span class="p">(</span>starttag<span class="p">,</span> midtag<span class="p">,</span> endtag<span class="p">,</span> flags<span class="p">,</span> skip<span class="p">,</span> stopline<span class="p">)</span></div><div class='line' id='LC84'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">endif</span></div><div class='line' id='LC85'>endfu</div><div class='line' id='LC86'><br/></div><div class='line' id='LC87'><span class="k">fu</span><span class="p">!</span> <span class="k">s</span>:HighlightTagAtPosition<span class="p">(</span>position<span class="p">)</span></div><div class='line' id='LC88'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="k">a</span>:position <span class="p">==</span> [<span class="m">0</span><span class="p">,</span> <span class="m">0</span>]</div><div class='line' id='LC89'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span></div><div class='line' id='LC90'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">endif</span></div><div class='line' id='LC91'><br/></div><div class='line' id='LC92'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> [m_lnum<span class="p">,</span> m_col] <span class="p">=</span> <span class="k">a</span>:position</div><div class='line' id='LC93'>&nbsp;&nbsp;&nbsp;&nbsp;exe <span class="s1">&#39;2match MatchParen /\(\%&#39;</span> . m_lnum . <span class="s1">&#39;l\%&#39;</span> . m_col .  <span class="s1">&#39;c&lt;\zs.\{-}\ze[\n &gt;]\)\|&#39;</span></div><div class='line' id='LC94'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\ .<span class="s1">&#39;\(\%&#39;</span> . line<span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">)</span> . <span class="s1">&#39;l\%&#39;</span> . <span class="k">col</span><span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">)</span> .  <span class="s1">&#39;c&lt;\zs.\{-}\ze[\n &gt;]\)\|&#39;</span></div><div class='line' id='LC95'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\ .<span class="s1">&#39;\(\%&#39;</span> . line<span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">)</span> . <span class="s1">&#39;l&lt;\zs[^&lt;&gt; ]*\%&#39;</span> . <span class="k">col</span><span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">)</span> . <span class="s1">&#39;c.\{-}\ze[\n &gt;]\)\|&#39;</span></div><div class='line' id='LC96'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\ .<span class="s1">&#39;\(\%&#39;</span> . line<span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">)</span> . <span class="s1">&#39;l&lt;\zs[^&lt;&gt;]\{-}\ze\s[^&lt;&gt;]*\%&#39;</span> . <span class="k">col</span><span class="p">(</span><span class="s1">&#39;.&#39;</span><span class="p">)</span> . <span class="s1">&#39;c.\{-}[\n&gt;]\)/&#39;</span></div><div class='line' id='LC97'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">let</span> <span class="k">w</span>:tag_hl_on <span class="p">=</span> <span class="m">1</span></div><div class='line' id='LC98'>endfu</div><div class='line' id='LC99'><br/></div><div class='line' id='LC100'><span class="c">&quot; vim: set ts=8 sts=4 sw=4 expandtab :</span></div></pre></div></td>
         </tr>
       </table>
  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2014 <span title="0.02802s from github-fe119-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x close js-ajax-error-dismiss" aria-label="Dismiss error"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-df9e4beac80276ed3dfa56be0d97b536d0f5ee12.js" type="text/javascript"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-df82ba4b57b9d4b49e4ef38975077d08caba28c5.js" type="text/javascript"></script>
      
      
        <script async src="https://www.google-analytics.com/analytics.js"></script>
  </body>
</html>

