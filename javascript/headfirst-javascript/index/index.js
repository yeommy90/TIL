let word = "병";
    let count = 99;
    while (count>0) {
      console.log(count + " " + word + "의 맥주가 벽장에 있다네,");
      console.log(count + " " + word + "의 맥주라네,");
      count = count - 1;
      if (count>0) {
        console.log(count + " " + word + "의 맥주가 벽장에 있네.");
      } else {
        console.log("이제 벽장엔 한" + word + "의 맥주도 없다네,");
      }
    }