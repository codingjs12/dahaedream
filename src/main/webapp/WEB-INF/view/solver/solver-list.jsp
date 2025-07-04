<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수락한 의뢰</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">
<jsp:include page="../../fragment/navbar.jsp"/>

<div class="container py-5">
    <h1 class="text-center mb-4">수락한 의뢰</h1>

    <!-- 탭 메뉴 -->
    <ul class="nav nav-tabs mb-4" id="requestTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="inprogress-tab" data-bs-toggle="tab" data-bs-target="#inprogress"
                    type="button" role="tab" onclick="fnGetAcceptRequest()">진행중</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="completed-tab" data-bs-toggle="tab" data-bs-target="#completed"
                    type="button" role="tab" onclick="fnGetCompleteRequest()">완료</button>
        </li>
    </ul>

    <!-- 탭 내용 -->
    <div class="tab-content" id="requestTabContent">
        <div class="tab-pane fade show active" id="inprogress" role="tabpanel">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4" id="inprogress-list"></div>
        </div>
        <div class="tab-pane fade" id="completed" role="tabpanel">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4" id="completed-list"></div>
        </div>
    </div>
</div>

<script>
    let memberId = 0;
    getMember();

    function getMember() {
        fetch("/getMember.dox", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({})
        })
            .then(res => res.json())
            .then(data => {
                memberId = data.memberId;
                fnGetAcceptRequest();
            });
    }

    function fnGetAcceptRequest() {
        fetch("/solver/getAcceptRequest.dox", {
            method: "POST",
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ solverId: memberId })
        })
            .then(res => res.json())
            .then(data => {
                const items = Array.isArray(data.list) ? data.list : [data.list];
                const container = document.querySelector("#inprogress-list");
                container.innerHTML = "";

                items.forEach(item => {
                    const card = `
                        <div class="col">
                            <div class="card h-100 shadow-sm">
                                <img src="\${item.filePath}" class="card-img-top" alt="썸네일">
                                <div class="card-body">
                                    <h5 class="card-title">\${item.title}</h5>
                                    <p class="card-text mb-1"><strong>카테고리:</strong> \${item.categoryName}</p>
                                    <p class="card-text mb-1"><strong>내용:</strong> \${item.content}</p>
                                    <p class="card-text"><strong>의뢰비:</strong> \${item.price}P</p>
                                </div>
                                <div class="card-footer bg-white border-top-0 text-end">
                                    <button class="btn btn-success btn-sm" onclick="fnComplete(\${item.requestId})">완료</button>
                                </div>
                            </div>
                        </div>`;
                    container.insertAdjacentHTML("beforeend", card);
                });
            });
    }

    function fnGetCompleteRequest() {
        fetch("/solver/getCompleteRequest.dox", {
            method: "POST",
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ solverId: memberId })
        })
            .then(res => res.json())
            .then(data => {
                const items = Array.isArray(data.list) ? data.list : [data.list];
                const container = document.querySelector("#completed-list");
                container.innerHTML = "";

                items.forEach(item => {
                    const card = `
                        <div class="col">
                            <div class="card h-100 shadow-sm">
                                <img src="\${item.filePath}" class="card-img-top" alt="썸네일">
                                <div class="card-body">
                                    <h5 class="card-title">\${item.title}</h5>
                                    <p class="card-text mb-1"><strong>카테고리:</strong> \${item.categoryName}</p>
                                    <p class="card-text mb-1"><strong>내용:</strong> \${item.content}</p>
                                    <p class="card-text"><strong>의뢰비:</strong> \${item.price}P</p>
                                </div>
                            </div>
                        </div>`;
                    container.insertAdjacentHTML("beforeend", card);
                });
            });
    }

    function fnComplete(requestId) {
        if (confirm("완료 처리하시겠습니까?")) {
            fetch("/solver/completeRequest.dox", {
                method: "POST",
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ requestId })
            })
                .then(res => res.json())
                .then(data => {
                    alert(data.message);
                    fnGetAcceptRequest();
                });
        }
    }
</script>
</body>
</html>
