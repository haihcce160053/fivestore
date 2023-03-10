// Hoang Liem

function showConfirmBox() {
    const overlay = document.getElementById("overlay1");
    const confirmBox = document.getElementById("confirm-box1");
    overlay.style.display = "block";
    confirmBox.style.display = "block";
}

function hideConfirmBox() {
    const overlay = document.getElementById("overlay1");
    const confirmBox = document.getElementById("confirm-box1");
    overlay.style.display = "none";
    confirmBox.style.display = "none";
}

function validateForm() {
    const pictureLink = document.getElementById("pictureLink").value;
    const productID = document.getElementById("productID").value;
    const productName = document.getElementById("productName").value;
    const description = document.getElementById("description").value;
    const type = document.getElementById("type").value;
    const quantity = document.getElementById("quantity").value;
    const price = document.getElementById("price").value;
    const exp = document.getElementById("exp").value;
    const origin = document.getElementById("origin").value;
    const soldAmount = document.getElementById("soldAmount").value;

    const regError = document.getElementById("regError");
    regError.innerHTML = "";

    if (pictureLink === "" || productID === "" || productName === "" || description === "" || type === "" || quantity === "" || price === "" || exp === "" || origin === "" || soldAmount === "") {
        regError.innerHTML = "Please fill in all fields.";
        return false;
    } else if (productID.length > 10) {
        regError.innerHTML = "Product ID cannot be more than 10 characters long.";
        return false;
    } else if (productName.length > 50) {
        regError.innerHTML = "Product name cannot be more than 50 characters long.";
        return false;
    } else if (isNaN(quantity) || isNaN(price) || isNaN(soldAmount)) {
        regError.innerHTML = "Quantity, price, and sold amount must be numbers.";
        return false;
    } else {
        return true;
    }
}
function convertToText(html) {
  let text = "";
  let lines = html.split(/<\/?(?:h2|h3|p|ul|ol)>/);

  for (let i = 0; i < lines.length; i++) {
    let line = lines[i].trim();

    if (line === "") {
      continue;
    }

    if (line.startsWith("Thông tin sản phẩm:")) {
      text += line + "\n";
    } else if (line.startsWith("Công dụng:")) {
      text += "\n" + line + "\n";
    } else if (line.startsWith("Đối tượng sử dụng:")) {
      text += "\n" + line + "\n";
    } else if (line.startsWith("Hướng dẫn sử dụng:")) {
      text += "\n" + line + "\n";
    } else if (line.startsWith("Lưu ý:")) {
      text += "\n" + line + "\n";
    } else if (line.startsWith("<li>")) {
      let listItems = line.split(/\<\/?li\>/g).filter(item => item.trim() !== "");
      listItems.forEach(item => {
        if (text.endsWith("\n")) {
          text += "- " + item + "\n";
        } else {
          text += "\n- " + item + "\n";
        }
      });
    } else {
      text += line + "\n";
    }
  }

  return text;
}


function convertToHTML(text) {
    let lines = text.split("\n");
    let html = "";
    let currentList = "";
    let currentListType = "";

    for (let i = 0; i < lines.length; i++) {
        let line = lines[i].trim();

        if (line === "") {
            continue;
        }

        if (line.startsWith("Thông tin sản phẩm:")) {
            html += "<h2>" + line + "</h2>";
        } else if (line.startsWith("Công dụng:")) {
            if (currentListType !== "") {
                html += "<" + currentListType + ">" + currentList + "</" + currentListType + ">";
                currentList = "";
                currentListType = "";
            }
            html += "<h3>" + line + "</h3>";
        } else if (line.startsWith("Đối tượng sử dụng:")) {
            if (currentListType !== "") {
                html += "<" + currentListType + ">" + currentList + "</" + currentListType + ">";
                currentList = "";
                currentListType = "";
            }
            html += "<h3>" + line + "</h3>";
            currentListType = "ul";
        } else if (line.startsWith("Hướng dẫn sử dụng:")) {
            if (currentListType !== "") {
                html += "<" + currentListType + ">" + currentList + "</" + currentListType + ">";
                currentList = "";
                currentListType = "";
            }
            html += "<h3>" + line + "</h3>";
            currentListType = "ul";
        } else if (line.startsWith("Lưu ý:")) {
            if (currentListType !== "") {
                html += "<" + currentListType + ">" + currentList + "</" + currentListType + ">";
                currentList = "";
                currentListType = "";
            }
            html += "<h3>" + line + "</h3>";
            currentListType = "ul";
        } else if (line.startsWith("-")) {
            if (currentListType === "") {
                currentListType = "ul";
            }
            if (currentListType === "ul") {
                currentList += "<li>" + line.substring(1).trim() + "</li>";
            }
        } else {
            if (currentList !== "") {
                html += "<" + currentListType + ">" + currentList + "</" + currentListType + ">";
                currentList = "";
                currentListType = "";
            }
            html += "<p>" + line + "</p>";
        }
    }

    if (currentList !== "") {
        html += "<" + currentListType + ">" + currentList + "</" + currentListType + ">";
    }

    return html;
}//end function

const form = document.querySelector("form");
form.addEventListener("submit", function (event) {
    event.preventDefault();
    if (validateForm()) {
        showConfirmBox();
        const overlay = document.getElementById("overlay1");
        const noButton = document.getElementById("no-button1");
        overlay.addEventListener("click", hideConfirmBox);
        noButton.addEventListener("click", hideConfirmBox);
        const yesButton = document.getElementById("yes-button1");
        yesButton.addEventListener("click", function () {
            const valueInTextArea = document.getElementById("description");
            let htmlString = convertToHTML(valueInTextArea.value);
            valueInTextArea.value = htmlString;
            form.submit();
        });
    }
}
);

