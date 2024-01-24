$(document).ready(function () {
    $('.authChangeBtn').click(function () {
        let userId = $(this).attr('id').split('_')[1];
        $('#authoritySelect_' + userId).show();
    });

    $(".authChangeBtn").click(function () {
        let confirmMessage = "권한을 변경하시겠습니까?";
        if (confirm(confirmMessage)) {
            let listRow = $(this).closest('.listRow');
            let authLevelSpan = listRow.find('#authLevel');
            let authoritySelect = listRow.find('.authoritySelect');
            let selectedValue = authoritySelect.val();


            $.ajax({
                type: "POST",
                url: "/updateAuthority",
                data: { userId: listRow.find('span:eq(1)').text(), newAuthority: selectedValue },
                success: function (data) {
                    if (selectedValue == 0) {
                        authLevelSpan.text('일반회원');
                    } else if (selectedValue == 1) {
                        authLevelSpan.text('서브관리자');
                    }

                    window.location.href = '/manager';
                },
                error: function (error) {
                    console.error("Error updating authority:", error);

                }
            });
        }
    });
    
    $(".delete_UserID").click(function () {
        let userId = $(this).attr('id').split('_')[1];
		let confirmMessage = userId + " 님을 강제 탈퇴 하시겠습니까?";
		
		if (confirm(confirmMessage)) {
			location.href= "deleteUser?del_uid="+userId;
			
			alert(userId + " 님을 강제탈퇴 하였습니다.");
		} 

    });
    
    
});