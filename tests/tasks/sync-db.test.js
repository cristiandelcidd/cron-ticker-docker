const { syncDB } = require("../../tasks/sync-db");

describe("Testing in Sync-DB", () => {
  test("should execute the process two times", () => {
    syncDB();
    const times = syncDB();

    expect(times).toBe(2);
  });
});
