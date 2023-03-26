let times = 0;

const syncDB = () => {
  times++;
  console.log("Tick every second", times);

  return times;
};

module.exports = { syncDB };
