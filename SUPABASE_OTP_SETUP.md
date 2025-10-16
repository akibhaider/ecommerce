# Supabase OTP Authentication Setup Guide

This guide will help you configure Supabase to enable OTP (One-Time Password) authentication for email verification and password reset.

## Step 1: Configure Supabase Authentication Settings

1. Go to your Supabase Dashboard: https://supabase.com/dashboard/project/qczskdexrlukonzimmks

2. Navigate to **Authentication** → **Settings**

3. **Enable Email Confirmations:**
   - Scroll to "Email Auth"
   - Check ✅ **Enable email confirmations**
   - This will require users to verify their email after signup

4. **Configure Email Templates:**
   Navigate to **Authentication** → **Email Templates**

   ### For Signup Confirmation (Confirm signup):
   Replace the existing template with:
   ```html
   <h2>Confirm Your Signup</h2>
   <p>Thank you for signing up! Please use the following 6-digit code to verify your email address:</p>
   
   <div style="background-color: #f4f4f4; padding: 20px; text-align: center; margin: 20px 0; border-radius: 8px;">
     <h1 style="color: #333; font-size: 36px; letter-spacing: 8px; margin: 0;">{{ .TokenHash }}</h1>
   </div>
   
   <p>This code will expire in 1 hour.</p>
   <p>If you didn't create an account, please ignore this email.</p>
   
   <p>Best regards,<br>E-Commerce Team</p>
   ```

   ### For Password Recovery (Magic Link):
   Replace the existing template with:
   ```html
   <h2>Reset Your Password</h2>
   <p>You requested to reset your password. Please use the following 6-digit code:</p>
   
   <div style="background-color: #f4f4f4; padding: 20px; text-align: center; margin: 20px 0; border-radius: 8px;">
     <h1 style="color: #333; font-size: 36px; letter-spacing: 8px; margin: 0;">{{ .TokenHash }}</h1>
   </div>
   
   <p>This code will expire in 1 hour.</p>
   <p>If you didn't request a password reset, please ignore this email.</p>
   
   <p>Best regards,<br>E-Commerce Team</p>
   ```

   **Important Template Variables:**
   - `{{ .TokenHash }}` - The 6-digit OTP code (use this for OTP display)
   - `{{ .Token }}` - Full token (don't use for OTP display)
   - `{{ .SiteURL }}` - Your app URL
   - `{{ .Email }}` - User's email address

5. **OTP Settings:**
   - Go to **Authentication** → **Settings** → **Auth Providers**
   - Ensure **Email** is enabled
   - Set **OTP Expiry**: 3600 seconds (1 hour) - you can adjust this
   - Enable **Secure email change** (optional)

6. **Security Settings (Recommended):**
   - **Rate Limiting**: 
     - Go to **Authentication** → **Rate Limits**
     - Set reasonable limits (e.g., 5 attempts per hour per email)
   - **CAPTCHA Protection**: Enable for production apps

## Step 2: Alternative Email Templates (More Styled)

If you want more professional-looking emails, use these templates:

### Professional Signup Template:
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
  <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
    <h1 style="color: white; margin: 0; font-size: 28px;">🛍️ Welcome to E-Commerce!</h1>
  </div>
  
  <div style="background-color: #ffffff; padding: 40px; border: 1px solid #e0e0e0; border-top: none; border-radius: 0 0 10px 10px;">
    <h2 style="color: #333; margin-top: 0;">Verify Your Email</h2>
    <p style="font-size: 16px; color: #666;">Thank you for signing up! To complete your registration, please enter this verification code in the app:</p>
    
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 25px; text-align: center; margin: 30px 0; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
      <p style="color: white; margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase; letter-spacing: 2px;">Your Verification Code</p>
      <h1 style="color: white; font-size: 42px; letter-spacing: 10px; margin: 0; font-weight: bold;">{{ .TokenHash }}</h1>
    </div>
    
    <div style="background-color: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0; border-radius: 4px;">
      <p style="margin: 0; color: #856404; font-size: 14px;">⏰ This code will expire in <strong>1 hour</strong></p>
    </div>
    
    <p style="font-size: 14px; color: #666; margin-top: 30px;">If you didn't create an account, you can safely ignore this email.</p>
    
    <hr style="border: none; border-top: 1px solid #e0e0e0; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      Best regards,<br>
      <strong>E-Commerce Team</strong>
    </p>
  </div>
</body>
</html>
```

### Professional Password Reset Template:
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
  <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
    <h1 style="color: white; margin: 0; font-size: 28px;">🔐 Password Reset</h1>
  </div>
  
  <div style="background-color: #ffffff; padding: 40px; border: 1px solid #e0e0e0; border-top: none; border-radius: 0 0 10px 10px;">
    <h2 style="color: #333; margin-top: 0;">Reset Your Password</h2>
    <p style="font-size: 16px; color: #666;">We received a request to reset your password. Enter this code in the app to proceed:</p>
    
    <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 25px; text-align: center; margin: 30px 0; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
      <p style="color: white; margin: 0 0 10px 0; font-size: 14px; text-transform: uppercase; letter-spacing: 2px;">Your Reset Code</p>
      <h1 style="color: white; font-size: 42px; letter-spacing: 10px; margin: 0; font-weight: bold;">{{ .TokenHash }}</h1>
    </div>
    
    <div style="background-color: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0; border-radius: 4px;">
      <p style="margin: 0; color: #856404; font-size: 14px;">⏰ This code will expire in <strong>1 hour</strong></p>
    </div>
    
    <div style="background-color: #f8d7da; border-left: 4px solid #dc3545; padding: 15px; margin: 20px 0; border-radius: 4px;">
      <p style="margin: 0; color: #721c24; font-size: 14px;">⚠️ If you didn't request this, please secure your account immediately.</p>
    </div>
    
    <hr style="border: none; border-top: 1px solid #e0e0e0; margin: 30px 0;">
    
    <p style="font-size: 12px; color: #999; text-align: center;">
      Best regards,<br>
      <strong>E-Commerce Team</strong>
    </p>
  </div>
</body>
</html>
```

## Step 3: Test the OTP Flow

### For Signup with Email Verification:

1. User fills signup form
2. App calls `signUp()` which sends OTP to email
3. User receives 6-digit code via email
4. User enters code in OTP verification screen
5. App calls `verifyOtp()` with type='signup'
6. User is verified and can login

### For Password Reset:

1. User clicks "Forgot Password"
2. User enters email
3. App calls `resetPasswordWithOtp()` which sends OTP to email
4. User receives 6-digit code via email
5. User enters code in OTP verification screen
6. App calls `verifyOtp()` with type='recovery'
7. After OTP verified, user enters new password
8. App calls `updatePassword()`
9. Password is reset successfully

## Step 4: Email Provider Configuration (Important!)

By default, Supabase uses a limited email service for development. For production:

1. Go to **Project Settings** → **Auth** → **SMTP Settings**
2. Configure your own SMTP provider (e.g., SendGrid, AWS SES, Mailgun)
3. Recommended providers:
   - **SendGrid**: Free tier available, easy setup
   - **AWS SES**: Cost-effective for high volume
   - **Mailgun**: Good for transactional emails

### Example SendGrid Configuration:
```
Host: smtp.sendgrid.net
Port: 587
Username: apikey
Password: <your-sendgrid-api-key>
Sender email: noreply@yourdomain.com
Sender name: Your App Name
```

## Step 5: Testing

### Test Signup OTP:
```dart
// In your app
await authService.signUp(
  email: 'test@example.com',
  password: 'Test123',
);
// Check email for OTP code
// Enter code in app
await authService.verifyOtp(
  email: 'test@example.com',
  token: '123456',
  type: 'signup',
);
```

### Test Password Reset OTP:
```dart
// Request OTP
await authService.resetPasswordWithOtp('test@example.com');
// Check email for OTP
// Verify OTP
await authService.verifyOtp(
  email: 'test@example.com',
  token: '123456',
  type: 'recovery',
);
// Reset password
await authService.updatePassword('NewPassword123');
```

## Step 6: Important Notes

### OTP Format:
- Supabase generates a 6-digit numeric code by default
- Valid for 1 hour (configurable)
- Case-insensitive

### Security Best Practices:
1. ✅ Always use HTTPS in production
2. ✅ Enable rate limiting to prevent OTP spam
3. ✅ Set appropriate OTP expiry time
4. ✅ Don't expose OTP codes in error messages
5. ✅ Implement account lockout after multiple failed attempts

### Common Issues:

**Email not arriving?**
- Check spam folder
- Verify SMTP settings
- Check Supabase logs in Dashboard → Logs
- Ensure email confirmations are enabled

**OTP verification fails?**
- Check if OTP has expired
- Ensure email address matches exactly
- Verify OTP type ('signup' vs 'recovery')
- Check for typos in the code

**"Invalid OTP" error?**
- OTP might have expired
- Use the "Resend" button to get a new code
- Check if user already verified (for signup)

## Step 7: Production Checklist

Before going to production:

- [ ] Configure custom SMTP provider
- [ ] Customize email templates with your branding
- [ ] Enable rate limiting
- [ ] Set appropriate OTP expiry time
- [ ] Test on real email addresses
- [ ] Enable CAPTCHA for signup/reset forms
- [ ] Set up email domain verification (SPF, DKIM)
- [ ] Monitor authentication logs

## Troubleshooting

### Enable Debug Mode in Supabase:
1. Go to Project Settings → API
2. Copy the service_role key (keep it secret!)
3. Use it to check auth logs programmatically

### View Auth Logs:
- Dashboard → Authentication → Users
- Click on a user to see their auth history
- Check "Logs" tab for detailed events

## Support

For more information:
- Supabase Docs: https://supabase.com/docs/guides/auth
- OTP Guide: https://supabase.com/docs/guides/auth/auth-email-otp
- Community: https://github.com/supabase/supabase/discussions
