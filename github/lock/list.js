const octokit = require('@octokit/rest')()

async function list() {
  let result;
  let page = 1;
  do {
    console.log(`=== Page ${page}`);
    page++;

    if (result) {
      result = await octokit.getNextPage(result);
    } else {
      // === GitHub's REST API v3 considers every pull request an issue ===
      //result = await octokit.pullRequests.getAll({ // https://octokit.github.io/rest.js/#api-PullRequests-getAll

      result = await octokit.issues.getForRepo({ // https://octokit.github.io/rest.js/#api-Issues-getForRepo
        owner: "jacoco",
        repo: "jacoco",
        state: "closed",
        per_page: 100, // max
        //milestone: 26, // 0.8.2
        //milestone: "none",
      });
    }

    result.data.forEach(function (item) {
      if (item.locked === false) {
        console.log(item.html_url);
      }
    });

  } while (octokit.hasNextPage(result));
  console.log(`=== DONE`)
}

list()
