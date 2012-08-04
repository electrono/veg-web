/*
SageFrameŽ - http://www.sageframe.com
Copyright (c) 2009-2010 by SageFrame
Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Drawing.Text;

namespace SageFrame
{
	public class CaptchaImage
	{
		// Public properties (all read-only).
		public string Text
		{
			get { return this.text; }
		}
		public Bitmap Image
		{
			get { return this.image; }
		}
		public int Width
		{
			get { return this.width; }
		}
		public int Height
		{
			get { return this.height; }
		}

		// Internal properties.
		private string text;
		private int width;
		private int height;
		private string familyName;
		private Bitmap image;

		// For generating random numbers.
		private Random random = new Random();

		// ====================================================================
		// Initializes a new instance of the CaptchaImage class using the
		// specified text, width and height.
		// ====================================================================
		public CaptchaImage(string s, int width, int height)
		{
			this.text = s;
			this.SetDimensions(width, height);
			this.GenerateImage();
		}

		// ====================================================================
		// Initializes a new instance of the CaptchaImage class using the
		// specified text, width, height and font family.
		// ====================================================================
		public CaptchaImage(string s, int width, int height, string familyName)
		{
			this.text = s;
			this.SetDimensions(width, height);
			this.SetFamilyName(familyName);
			this.GenerateImage();
		}

		// ====================================================================
		// This member overrides Object.Finalize.
		// ====================================================================
		~CaptchaImage()
		{
			Dispose(false);
		}

		// ====================================================================
		// Releases all resources used by this object.
		// ====================================================================
		public void Dispose()
		{
			GC.SuppressFinalize(this);
			this.Dispose(true);
		}

		// ====================================================================
		// Custom Dispose method to clean up unmanaged resources.
		// ====================================================================
		protected virtual void Dispose(bool disposing)
		{
			if (disposing)
				// Dispose of the bitmap.
				this.image.Dispose();
		}

		// ====================================================================
		// Sets the image width and height.
		// ====================================================================
		private void SetDimensions(int width, int height)
		{
			// Check the width and height.
			if (width <= 0)
				throw new ArgumentOutOfRangeException("width", width, "Argument out of range, must be greater than zero.");
			if (height <= 0)
				throw new ArgumentOutOfRangeException("height", height, "Argument out of range, must be greater than zero.");
			this.width = width;
			this.height = height;
		}

		// ====================================================================
		// Sets the font used for the image text.
		// ====================================================================
		private void SetFamilyName(string familyName)
		{
			// If the named font is not installed, default to a system font.
			try
			{
				Font font = new Font(this.familyName, 12F);
				this.familyName = familyName;
				font.Dispose();
			}
			catch
			{
				this.familyName = System.Drawing.FontFamily.GenericSerif.Name;
			}
		}

		// ====================================================================
		// Creates the bitmap image.
		// ====================================================================
		private void GenerateImage()
		{
			// Create a new 32-bit bitmap image.
			Bitmap bitmap = new Bitmap(this.width, this.height, PixelFormat.Format48bppRgb);

			// Create a graphics object for drawing.
			Graphics g = Graphics.FromImage(bitmap);
			g.SmoothingMode = SmoothingMode.AntiAlias;
			Rectangle rect = new Rectangle(0, 0, this.width, this.height);

			// Fill in the background.
			HatchBrush hatchBrush = new HatchBrush(HatchStyle.SmallConfetti, Color.LightGray, Color.White);
			g.FillRectangle(hatchBrush, rect);

			// Set up the text font.
			SizeF size;
            float fontSize = rect.Height+1;
			Font font;
			// Adjust the font size until the text fits within the image.
            float fontWidth = rect.Width;
			do
			{
                fontSize--;
				font = new Font(this.familyName, fontSize, FontStyle.Bold);
				size = g.MeasureString(this.text, font);
			} while (size.Width > fontWidth);

			// Set up the text format.
			StringFormat format = new StringFormat();
			format.Alignment = StringAlignment.Center;
			format.LineAlignment = StringAlignment.Center;

			// Create a path using the text and warp it randomly.
			GraphicsPath path = new GraphicsPath();
            //Size fSize = new Size();
            //fSize.Height =  int.Parse(Math.Abs(rect.Height*0.9).ToString());
            //fSize.Width = int.Parse(Math.Abs(rect.Width * 0.9).ToString());
            //PointF poinf = new PointF();
            //poinf.X = float.Parse(Math.Abs(rect.Width * 0.9).ToString());
            //poinf.Y = float.Parse(Math.Abs(rect.Height * 0.9).ToString());
			path.AddString(this.text, font.FontFamily, (int) font.Style, font.Size, rect, format);
			float v = 4F;
			PointF[] points =
			{
				new PointF(this.random.Next(rect.Width) / v, this.random.Next(rect.Height) / v),
				new PointF(rect.Width - this.random.Next(rect.Width) / v, this.random.Next(rect.Height) / v),
				new PointF(this.random.Next(rect.Width) / v, rect.Height - this.random.Next(rect.Height) / v),
				new PointF(rect.Width - this.random.Next(rect.Width) / v, rect.Height - this.random.Next(rect.Height) / v)
			};
			Matrix matrix = new Matrix();
			matrix.Translate(0F, 0F);
			path.Warp(points, rect, matrix, WarpMode.Perspective, 0F);

			// Draw the text.
			hatchBrush = new HatchBrush(HatchStyle.LargeConfetti, Color.LightGray, Color.DarkGray);
			g.FillPath(hatchBrush, path);

			// Add some random noise.
			int m = Math.Max(rect.Width, rect.Height);
			for (int i = 0; i < (int) (rect.Width * rect.Height / 30F); i++)
			{
				int x = this.random.Next(rect.Width);
				int y = this.random.Next(rect.Height);
				int w = this.random.Next(m / 50);
				int h = this.random.Next(m / 50);
				g.FillEllipse(hatchBrush, x, y, w, h);
			}

			// Clean up.
			font.Dispose();
			hatchBrush.Dispose();
			g.Dispose();

			// Set the image.
			this.image = bitmap;
		}
	}
}
