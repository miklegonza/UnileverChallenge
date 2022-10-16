var arr = [
  {
    job: "j4",
    at: 0,
    bt: 8,
  },
  {
    job: "j2",
    at: 2,
    bt: 4,
  },
  {
    job: "j3",
    at: 2,
    bt: 5,
  },
  {
    job: "j5",
    at: 6,
    bt: 4,
  },
  {
    job: "j1",
    at: 8,
    bt: 3,
  },
];

var active = undefined,
  queue = [],
  final = [],
  totalBurst = 0,
  currentBurst = 0;

// Get the total burst time
$.map(arr, function (job, index) {
  arr[index].runTime = arr[index].bt;
  totalBurst += job.bt + job.at;
});

// This loop simulates time
for (var i = 0; i < totalBurst; i += 1) {
  if (typeof active === "object") {
    active.runTime -= 1;

    if (active.runTime < 1) {
      final.push({ job: active.job, start: active.start, end: i });
      active = undefined;
    }
  }

  // Get array of jobs recieved at this time signature
  var toProcess,
    jobs = $.grep(arr, function (job, index) {
      return job.at === i;
    });

  // Merge new jobs into queue
  queue = queue.concat(jobs);
  // Sort the queue
  queue.sort(function (a, b) {
    return a.bt < b.bt ? -1 : 1;
  });

  // Get the job to process next
  toProcess = queue.splice(0, 1)[0];

  if (typeof toProcess !== "undefined") {
    // Process active job
    if (typeof active === "undefined" && typeof toProcess !== "undefined") {
      // Automatically start the first job in the queue
      toProcess.start = i;
      active = toProcess;
    } else if (typeof toProcess !== "undefined" && active.bt > toProcess.bt) {
      // Push active time to final array
      final.push({ job: active.job, start: active.start, end: i });
      // If active still has time to run add it to queue
      if (active.runTime > 0) {
        queue.push(active);
      }

      // Create new active process
      toProcess.start = i;
      active = toProcess;
    } else if (typeof toProcess !== "undefined") {
      // Otherwise we still have an active process
      // Push the toProcess back on the queue
      queue.push(toProcess);
    }
  }
}

var jobSingle = $(".singleJob").remove(),
  container = $("#container tbody");

$.each(final, function (index, job) {
  var el = jobSingle.clone();

  el.children()
    .first()
    .text(job.job)
    .next()
    .text(job.start)
    .next()
    .text(job.end);

  container.append(el);
});
