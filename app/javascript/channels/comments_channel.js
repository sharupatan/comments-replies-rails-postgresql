import consumer from "./consumer"

const commentsChannel = consumer.subscriptions.create("CommentsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const commentsSection = document.getElementById('comments-section');
    commentsSection.insertAdjacentHTML('beforeend', renderComment(data.comment));
  },

  sendComment(userId, title) {
    this.perform('send_comment', { user_id: userId, title: title });
  },

  sendReply(commentId, title, userId) {
    this.perform('send_reply', { comment_id: commentId, title: title, user_id: userId });
  }
});

// Function to render a comment (you may want to customize this)
function renderComment(comment) {
  return `
    <div class="card mb-2 shadow">
      <div class="card-body">
        <div class='row'>
          <h5 class="card-title col-1 text-start">${comment.id}:</h5>
          <p class="card-text col-10 text-start">${comment.title}</p>
          <a href="#" class="btn btn-primary col-1">Like <span class='badge bg-danger'>${comment.likes_count}</span></a>
        </div>
        <hr/>
        <div class='row text-center'>
          <textarea placeholder="Write a reply..." id="reply-input-${comment.id}" class="col-10"></textarea>
          <button onclick="sendReply(${comment.id})" class="btn btn-info col-2">Reply</button>
        </div>
        ${Object.values(comment.replies).map(reply => `
          <p class="text-start"><strong>${comment.user?.name}:</strong> ${reply.content}</p>
        `).join('')}
      </div>
    </div>
  `;
}

// Function to send a reply
function sendReply(commentId) {
  const title = document.getElementById(`reply-input-${commentId}`).value;
  const userId = 1; // Replace with actual user ID
  commentsChannel.sendReply(commentId, title, userId);
}

window.commentsChannel = commentsChannel;