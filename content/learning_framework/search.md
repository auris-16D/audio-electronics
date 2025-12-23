---
title: "Search"
section: "Learning Framework"
status: "active"
weight: 6
summary: "Search the site using a fully static index (Pagefind)."
---

<link href="/pagefind/pagefind-ui.css" rel="stylesheet">
<script src="/pagefind/pagefind-ui.js"></script>

<div id="search"></div>

<script>
  window.addEventListener("DOMContentLoaded", () => {
    new PagefindUI({
      element: "#search",
      showSubResults: true
    });
  });
</script>
